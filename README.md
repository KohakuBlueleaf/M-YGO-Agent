# M-YGO Agent: 

original code/project: https://github.com/sbl1996/ygo-agent

## Overview
M-YGO Agent is a project forked from the original YGO-agent project for continued development and improvements.

We introduce following updates and features:
* Improved install method and project structure
* Updated makefile for latest card database
* A complete workflows for getting latest card scripts from YGOPro1/2 based app
   * For example, you can copy the card scripts from MDPro3 and it will contain the latest card scripts.
* Fixes for correct compilation
   * In `src/ygoenv/<ENGNAME>/<ENGNAME>.hpp`, the initilization of `Spec` class is modified to use explicit `std::tuple<dtype, dtype>` type identifier to avoid ambiguity in template deduction.
   * For example: `info:num_options"_.Bind(Spec<int>({}, {0, conf["max_options"_] - 1}))` is modified to `info:num_options"_.Bind(Spec<int>({}, std::tuple<int, int>{0, conf["max_options"_] - 1}))`
   * There are some other similar changes in the codebase to ensure correct template deduction.
   * For comparing the modification, it is recommended to clone this repository seperatedly and copy the src/ygoenv under this repo to the ygoenv/ygoenv directory of the original YGO-agent repository.

## Installation
Clone this repository and follow the "build from source" instructions in the original YGO-agent repository.

For testing, you can use the following command:
```bash
cd scripts
python ./test.py  --deck ../assets/deck/ --num_envs 1 --num_episodes 1 --verbose
```

### Update card scripts from MDPro3
In MDPro3 installation (`xxx/MDPro3`), you can find a zip file `Data/script.zip` and there is a folder `script` inside it. You can copy the content of script folder (lot of lua file) to `script/script` folder, than run the `scripts/card/code_list.py` script under `scripts` folder to generate the `code_list.txt` file, after doing this you should be able to utilize deck with latest card scripts.

to test if your operation is successful, you can run the following command:
```bash
cd scripts
python ./test.py  --deck ../assets/deck/ --num_envs 1 --num_episodes 1 --verbose  --deck1 DragonMaidTail --deck2 TenpaiDragonMaid
```
Where `DragonMaidTail` and `TenpaiDragonMaid` are the decks who utilize DragonTail series cards and TenpaiDragon series cards, which are the latest cards in MDPro3. And not fully supported in Mycard's card script list. But MDPro3 has the latest card scripts, so you can use it to test the latest cards.

## TODOs
- [ ] A more comprehensive document on "how to use the ygoenv"
- [ ] Examples of ygoenv usage for making RL agent
- [ ] RL Agent implementation in pytorch
- [ ] Fix the record functionality

## Known Issues
* EDOPro backend is not working properly, it is recommended to use YGOPro-v1 backend
  * Some updates upstream break current implementation in ygoenv/edopro, we need to find the exact working commit to make it work again.
* Record feature not working correctly, the generated yrp file cannot be parsed by MDPro3.