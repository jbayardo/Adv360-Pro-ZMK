#!/bin/bash

# This script assumes a ~/zmk fork of the official zmk repository exists. It'll basically reset that fork to a state
# where:
# 
# 1. zmk is at the latest version
# 2. Kinesis Advantage 360 Pro's firmware is available and at the latest version
# 3. Several extra behaviors are available.

# See: https://gist.github.com/urob/68a1e206b2356a01b876ed02d3f542c7
cd ~/zmk

git remote add -t main upstream https://github.com/zmkfirmware/zmk
git remote add kinesis https://github.com/ReFil/zmk
git remote add mcrosson https://github.com/mcrosson/zmk
git remote add nickconway https://github.com/nickconway/zmk
git remote add urob https://github.com/urob/zmk
git remote add andrewjrae https://github.com/andrewjrae/zmk
git remote add krikun98 https://github.com/krikun98/zmk
git remote add ftc https://github.com/ftc/zmk

git clean -xf
git reset --hard origin/main
git fetch --all
git checkout main
git pull

git reset --hard upstream/main

# Help there be no merge conflicts. These are _mostly_ safe.
cat >> .gitattributes<< EOF
app/Kconfig merge=union
app/CMakeLists.txt merge=union
app/dts/behaviors.dtsi merge=union
*.md merge=union
*.js merge=union
EOF

# See: Kinesis Advantage 360 Pro Firmware
git merge -Xignore-all-space -Xpatience -Xdiff-algorithm=patience kinesis/adv360-z3 --squash
git commit -m "Kinesis Advantage 360 Pro Firmware Support"

# See: https://github.com/zmkfirmware/zmk/pull/1351
git merge -Xignore-all-space -Xpatience -Xdiff-algorithm=patience nickconway/dynamic-macro --squash
git commit -m "Dynamic Macro"

# See: https://github.com/zmkfirmware/zmk/pull/1398
git merge -Xignore-all-space -Xpatience -Xdiff-algorithm=patience nickconway/hold_while_undecided --squash
git commit -m "Hold-Tap Hold While Undecided"

# See: https://github.com/zmkfirmware/zmk/pull/1366
# Example: https://github.com/caksoylar/zmk-config/commit/36d04be8a416ffa88e6c7e59e0ddee403906987b
git merge -Xignore-all-space -Xpatience -Xdiff-algorithm=patience nickconway/smart-interrupt --squash
git commit -m "Swapper"

# See: https://github.com/zmkfirmware/zmk/pull/1380
git merge -Xignore-all-space -Xpatience -Xdiff-algorithm=patience nickconway/leader-key --squash
git commit -m "Leader Key"

# See: https://github.com/zmkfirmware/zmk/pull/1451
git merge -Xignore-all-space -Xpatience -Xdiff-algorithm=patience urob/improve-caps-word --squash
git commit -m "Smart layers and cap word enhancements"

# See: https://github.com/zmkfirmware/zmk/pull/1387
git merge -Xignore-all-space -Xpatience -Xdiff-algorithm=patience andrewjrae/min-prior-ms --squash
git commit -m "global-quick-tap-ms"

# See: https://github.com/zmkfirmware/zmk/pull/778
git merge -Xignore-all-space -Xpatience -Xdiff-algorithm=patience ftc/mouse-ftc --squash
git commit -m "Mouse keys support"

# See: https://github.com/zmkfirmware/zmk/pull/649
# git merge -Xignore-all-space -Xpatience -Xdiff-algorithm=patience mcrosson/feat-behavior-sleep --squash
# git commit -m "Sleep Behavior"

git push --force