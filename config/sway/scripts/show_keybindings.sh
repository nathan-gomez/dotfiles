#!/usr/bin/env bash
CONFIG="${HOME}/.config/sway/config.d/keybindings"

# 1. Collect variables
declare -A VARS
while IFS= read -r line; do
    if [[ "$line" =~ ^[[:space:]]*set[[:space:]]+(\$[^[:space:]]+)[[:space:]]+(.+) ]]; then
        VARS["${BASH_REMATCH[1]}"]="${BASH_REMATCH[2]}"
    fi
done < "$CONFIG"

# 2. Resolve variables and prettify modifier names
resolve() {
    local str="$1"
    for var in $(echo "${!VARS[@]}" | tr ' ' '\n' | sort -r); do
        str="${str//${var}/${VARS[$var]}}"
    done
    str="${str//Mod4/Super}"
    str="${str//Mod1/Alt}"
    echo "$str"
}

# 3. Translate bindcode keycodes 10-19 to key names 1-0
keycode_to_name() {
    case "$1" in
        10) echo "1" ;; 11) echo "2" ;; 12) echo "3" ;;
        13) echo "4" ;; 14) echo "5" ;; 15) echo "6" ;;
        16) echo "7" ;; 17) echo "8" ;; 18) echo "9" ;;
        19) echo "0" ;; *) echo "key$1" ;;
    esac
}

# 4. Parse the config file
last_comment=""
in_block=0
block_type=""      # "bindsym", "bindcode", or "skip"
block_comment=""

output=""

emit() {
    local key="$1"
    local desc="$2"
    output+="$(printf '%-30s  %s' "$key" "$desc")"$'\n'
}

while IFS= read -r line; do
    # Bare # line — section boundary marker, reset comment state
    if [[ "$line" =~ ^#[[:space:]]*$ ]]; then
        last_comment=""
        continue
    fi

    # Unindented "# Header" line — not a binding description, reset comment state
    if [[ "$line" =~ ^#[[:space:]] ]] && [[ $in_block -eq 0 ]]; then
        last_comment=""
        continue
    fi

    # Skip block start with flags (mouse bindings — not worth showing)
    if [[ "$line" =~ ^[[:space:]]*(bindsym|bindcode)[[:space:]]+--[^{]+\{[[:space:]]*$ ]]; then
        in_block=1
        block_type="skip"
        last_comment=""
        continue
    fi

    # Block start: "bindsym {" or "bindcode {"
    if [[ "$line" =~ ^[[:space:]]*(bindsym|bindcode)[[:space:]]*\{[[:space:]]*$ ]]; then
        in_block=1
        block_type="${BASH_REMATCH[1]}"
        block_comment=""
        last_comment=""
        continue
    fi

    # Block end
    if [[ $in_block -eq 1 && "$line" =~ ^[[:space:]]*\}[[:space:]]*$ ]]; then
        in_block=0
        block_type=""
        block_comment=""
        last_comment=""
        continue
    fi

    # Inside a block
    if [[ $in_block -eq 1 ]]; then
        # Comment inside block
        if [[ "$line" =~ ^[[:space:]]+#[[:space:]]*(.+)$ ]]; then
            block_comment="${BASH_REMATCH[1]}"
            continue
        fi

        [[ "$block_type" == "skip" ]] && continue

        # Binding line inside block: "key action"
        if [[ "$line" =~ ^[[:space:]]+([^[:space:]]+)[[:space:]]+(.+)$ ]]; then
            raw_key="${BASH_REMATCH[1]}"
            action="${BASH_REMATCH[2]}"

            if [[ "$block_type" == "bindcode" ]]; then
                if [[ "$raw_key" =~ ^(.*)\+([0-9]+)$ ]]; then
                    raw_key="${BASH_REMATCH[1]}+$(keycode_to_name "${BASH_REMATCH[2]}")"
                fi
            fi

            resolved_key="$(resolve "$raw_key")"
            desc="${block_comment:-$(resolve "$action")}"
            emit "$resolved_key" "$desc"
            block_comment=""
        fi
        continue
    fi

    # Indented comment line (outside block) — description for next binding
    if [[ "$line" =~ ^[[:space:]]+#[[:space:]]*(.+)$ ]]; then
        last_comment="${BASH_REMATCH[1]}"
        continue
    fi

    # Single bindsym/bindcode line
    if [[ "$line" =~ ^[[:space:]]*(bindsym|bindcode)[[:space:]]+(\$[^[:space:]]+\+[^[:space:]]+|[^[:space:]]+\+[^[:space:]]+|[^[:space:]]+)[[:space:]]+(.+)$ ]]; then
        bind_type="${BASH_REMATCH[1]}"
        raw_key="${BASH_REMATCH[2]}"
        action="${BASH_REMATCH[3]}"

        # Skip lines with flags like --whole-window
        if [[ "$raw_key" == --* ]]; then
            last_comment=""
            continue
        fi

        if [[ "$bind_type" == "bindcode" ]]; then
            if [[ "$raw_key" =~ ^(.*)\+([0-9]+)$ ]]; then
                raw_key="${BASH_REMATCH[1]}+$(keycode_to_name "${BASH_REMATCH[2]}")"
            fi
        fi

        resolved_key="$(resolve "$raw_key")"
        desc="${last_comment:-$(resolve "$action")}"
        emit "$resolved_key" "$desc"
        last_comment=""
        continue
    fi

    # Any other non-empty line resets last_comment
    if [[ -n "${line//[[:space:]]/}" ]]; then
        last_comment=""
    fi

done < "$CONFIG"

# 5. Display in fuzzel dmenu mode
echo "$output" | fuzzel --dmenu \
    --placeholder "Search keybindings…" \
    --no-run-if-empty \
    --width 120 \
    --lines 20
