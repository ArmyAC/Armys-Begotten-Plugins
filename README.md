A list of my plugins that are free to use. Note that most of these are going to require some level of edits to your code and cannot work standalone. I'll have a guide for each plugin to walk you through it. Most of it is just adding hooks to the code. You can remove the hooks and just put the code in, if you want. I just like making hooks. Plugins will be updated to add more features or bugfixes to them. You can message me at .army on Discord if you need some help or other aid. Please report any bugs or suggestions to me.

Some of these are not extensively bug-tested.

I do not upload my edited files with the added hooks because there is a high likelihood that they will be updated over time on main branch and cause issues later on.


## Playermode
Playermode is a plugin that was first made on Apocalypse. My version is different from the one that was used on Apoc's. Apoc's was a little better than mine, but I'll update mine to have the same feature list as theirs later on.
This plugin requires edits to your gamemode.

![image](https://github.com/user-attachments/assets/e86a8355-cb86-4a73-81ec-a4b3dfa93db4)

You need to add line 43, 45 to your code in plugins/observermode/plugin/sv_plugin.lua. This might not actually be required, so test it at your own volition.

Another hook that needs to be added is:

![image](https://github.com/user-attachments/assets/9397530d-0556-4cf9-b54d-eda0fad415b5)

You need to add 1007-1016 in clockwork/framework/cl_kernel.lua.

Once added, you should be good to go.

## Bounty Text
Bounty text is a pretty simple plugin - it does exactly what it says. It adds bounty text to characters' heads if they're on the bounty board.

It requires a hook being added to clockwork/framework/hooks/cl_hooks.lua at 2710.
I've highlighted it in red to be easier to identify through the linter screaming.

![image](https://github.com/user-attachments/assets/75cf6e1d-c097-4e82-8a5e-b48c0284d30c)

After that, you're good to go.


