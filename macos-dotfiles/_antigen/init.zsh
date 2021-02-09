#-- START ZCACHE GENERATED FILE
#-- GENERATED: Sun  7 Feb 2021 19:34:33 EET
#-- ANTIGEN v2.2.3
_antigen () {
	local -a _1st_arguments
	_1st_arguments=('apply:Load all bundle completions' 'bundle:Install and load the given plugin' 'bundles:Bulk define bundles' 'cleanup:Clean up the clones of repos which are not used by any bundles currently loaded' 'cache-gen:Generate cache' 'init:Load Antigen configuration from file' 'list:List out the currently loaded bundles' 'purge:Remove a cloned bundle from filesystem' 'reset:Clears cache' 'restore:Restore the bundles state as specified in the snapshot' 'revert:Revert the state of all bundles to how they were before the last antigen update' 'selfupdate:Update antigen itself' 'snapshot:Create a snapshot of all the active clones' 'theme:Switch the prompt theme' 'update:Update all bundles' 'use:Load any (supported) zsh pre-packaged framework') 
	_1st_arguments+=('help:Show this message' 'version:Display Antigen version') 
	__bundle () {
		_arguments '--loc[Path to the location <path-to/location>]' '--url[Path to the repository <github-account/repository>]' '--branch[Git branch name]' '--no-local-clone[Do not create a clone]'
	}
	__list () {
		_arguments '--simple[Show only bundle name]' '--short[Show only bundle name and branch]' '--long[Show bundle records]'
	}
	__cleanup () {
		_arguments '--force[Do not ask for confirmation]'
	}
	_arguments '*:: :->command'
	if (( CURRENT == 1 ))
	then
		_describe -t commands "antigen command" _1st_arguments
		return
	fi
	local -a _command_args
	case "$words[1]" in
		(bundle) __bundle ;;
		(use) compadd "$@" "oh-my-zsh" "prezto" ;;
		(cleanup) __cleanup ;;
		(update|purge) compadd $(type -f \-antigen-get-bundles &> /dev/null || antigen &> /dev/null; -antigen-get-bundles --simple 2> /dev/null) ;;
		(theme) compadd $(type -f \-antigen-get-themes &> /dev/null || antigen &> /dev/null; -antigen-get-themes 2> /dev/null) ;;
		(list) __list ;;
	esac
}
antigen () {
  local MATCH MBEGIN MEND
  [[ "$ZSH_EVAL_CONTEXT" =~ "toplevel:*" || "$ZSH_EVAL_CONTEXT" =~ "cmdarg:*" ]] && source "/usr/local/Cellar/antigen/2.2.3/share/antigen/antigen.zsh" && eval antigen $@;
  return 0;
}
typeset -gaU fpath path
fpath+=(/Users/alkuzmanov/Documents/Drugi-lichni-neshta-alk19890105/Rabotilnitsa-programirane-alk19890105/dotfiles-alk19890105-v3.0/macos-dotfiles/_antigen/bundles/robbyrussell/oh-my-zsh/plugins/git /Users/alkuzmanov/Documents/Drugi-lichni-neshta-alk19890105/Rabotilnitsa-programirane-alk19890105/dotfiles-alk19890105-v3.0/macos-dotfiles/_antigen/bundles/robbyrussell/oh-my-zsh/plugins/autojump /Users/alkuzmanov/Documents/Drugi-lichni-neshta-alk19890105/Rabotilnitsa-programirane-alk19890105/dotfiles-alk19890105-v3.0/macos-dotfiles/_antigen/bundles/robbyrussell/oh-my-zsh/plugins/ssh-agent /Users/alkuzmanov/Documents/Drugi-lichni-neshta-alk19890105/Rabotilnitsa-programirane-alk19890105/dotfiles-alk19890105-v3.0/macos-dotfiles/_antigen/bundles/robbyrussell/oh-my-zsh/plugins/extract /Users/alkuzmanov/Documents/Drugi-lichni-neshta-alk19890105/Rabotilnitsa-programirane-alk19890105/dotfiles-alk19890105-v3.0/macos-dotfiles/_antigen/bundles/robbyrussell/oh-my-zsh/plugins/vi-mode /Users/alkuzmanov/Documents/Drugi-lichni-neshta-alk19890105/Rabotilnitsa-programirane-alk19890105/dotfiles-alk19890105-v3.0/macos-dotfiles/_antigen/bundles/robbyrussell/oh-my-zsh/plugins/command-not-found /Users/alkuzmanov/Documents/Drugi-lichni-neshta-alk19890105/Rabotilnitsa-programirane-alk19890105/dotfiles-alk19890105-v3.0/macos-dotfiles/_antigen/bundles/robbyrussell/oh-my-zsh/plugins/docker /Users/alkuzmanov/Documents/Drugi-lichni-neshta-alk19890105/Rabotilnitsa-programirane-alk19890105/dotfiles-alk19890105-v3.0/macos-dotfiles/_antigen/bundles/zsh-users/zsh-syntax-highlighting /Users/alkuzmanov/Documents/Drugi-lichni-neshta-alk19890105/Rabotilnitsa-programirane-alk19890105/dotfiles-alk19890105-v3.0/macos-dotfiles/_antigen/bundles/zsh-users/zsh-autosuggestions /Users/alkuzmanov/Documents/Drugi-lichni-neshta-alk19890105/Rabotilnitsa-programirane-alk19890105/dotfiles-alk19890105-v3.0/macos-dotfiles/_antigen/bundles/zsh-users/zsh-completions /Users/alkuzmanov/Documents/Drugi-lichni-neshta-alk19890105/Rabotilnitsa-programirane-alk19890105/dotfiles-alk19890105-v3.0/macos-dotfiles/_antigen/bundles/superbrothers/zsh-kubectl-prompt) path+=(/Users/alkuzmanov/Documents/Drugi-lichni-neshta-alk19890105/Rabotilnitsa-programirane-alk19890105/dotfiles-alk19890105-v3.0/macos-dotfiles/_antigen/bundles/robbyrussell/oh-my-zsh/plugins/git /Users/alkuzmanov/Documents/Drugi-lichni-neshta-alk19890105/Rabotilnitsa-programirane-alk19890105/dotfiles-alk19890105-v3.0/macos-dotfiles/_antigen/bundles/robbyrussell/oh-my-zsh/plugins/autojump /Users/alkuzmanov/Documents/Drugi-lichni-neshta-alk19890105/Rabotilnitsa-programirane-alk19890105/dotfiles-alk19890105-v3.0/macos-dotfiles/_antigen/bundles/robbyrussell/oh-my-zsh/plugins/ssh-agent /Users/alkuzmanov/Documents/Drugi-lichni-neshta-alk19890105/Rabotilnitsa-programirane-alk19890105/dotfiles-alk19890105-v3.0/macos-dotfiles/_antigen/bundles/robbyrussell/oh-my-zsh/plugins/extract /Users/alkuzmanov/Documents/Drugi-lichni-neshta-alk19890105/Rabotilnitsa-programirane-alk19890105/dotfiles-alk19890105-v3.0/macos-dotfiles/_antigen/bundles/robbyrussell/oh-my-zsh/plugins/vi-mode /Users/alkuzmanov/Documents/Drugi-lichni-neshta-alk19890105/Rabotilnitsa-programirane-alk19890105/dotfiles-alk19890105-v3.0/macos-dotfiles/_antigen/bundles/robbyrussell/oh-my-zsh/plugins/command-not-found /Users/alkuzmanov/Documents/Drugi-lichni-neshta-alk19890105/Rabotilnitsa-programirane-alk19890105/dotfiles-alk19890105-v3.0/macos-dotfiles/_antigen/bundles/robbyrussell/oh-my-zsh/plugins/docker /Users/alkuzmanov/Documents/Drugi-lichni-neshta-alk19890105/Rabotilnitsa-programirane-alk19890105/dotfiles-alk19890105-v3.0/macos-dotfiles/_antigen/bundles/zsh-users/zsh-syntax-highlighting /Users/alkuzmanov/Documents/Drugi-lichni-neshta-alk19890105/Rabotilnitsa-programirane-alk19890105/dotfiles-alk19890105-v3.0/macos-dotfiles/_antigen/bundles/zsh-users/zsh-autosuggestions /Users/alkuzmanov/Documents/Drugi-lichni-neshta-alk19890105/Rabotilnitsa-programirane-alk19890105/dotfiles-alk19890105-v3.0/macos-dotfiles/_antigen/bundles/zsh-users/zsh-completions /Users/alkuzmanov/Documents/Drugi-lichni-neshta-alk19890105/Rabotilnitsa-programirane-alk19890105/dotfiles-alk19890105-v3.0/macos-dotfiles/_antigen/bundles/superbrothers/zsh-kubectl-prompt)
_antigen_compinit () {
  autoload -Uz compinit; compinit -i -d "/Users/alkuzmanov/.antigen/.zcompdump"; compdef _antigen antigen
  add-zsh-hook -D precmd _antigen_compinit
}
autoload -Uz add-zsh-hook; add-zsh-hook precmd _antigen_compinit
compdef () {}

if [[ -n "/Users/alkuzmanov/.oh-my-zsh" ]]; then
  ZSH="/Users/alkuzmanov/.oh-my-zsh"; ZSH_CACHE_DIR="/Users/alkuzmanov/.oh-my-zsh/cache"
fi
#--- BUNDLES BEGIN
source '/Users/alkuzmanov/Documents/Drugi-lichni-neshta-alk19890105/Rabotilnitsa-programirane-alk19890105/dotfiles-alk19890105-v3.0/macos-dotfiles/_antigen/bundles/robbyrussell/oh-my-zsh/plugins/git/git.plugin.zsh';
source '/Users/alkuzmanov/Documents/Drugi-lichni-neshta-alk19890105/Rabotilnitsa-programirane-alk19890105/dotfiles-alk19890105-v3.0/macos-dotfiles/_antigen/bundles/robbyrussell/oh-my-zsh/plugins/autojump/autojump.plugin.zsh';
source '/Users/alkuzmanov/Documents/Drugi-lichni-neshta-alk19890105/Rabotilnitsa-programirane-alk19890105/dotfiles-alk19890105-v3.0/macos-dotfiles/_antigen/bundles/robbyrussell/oh-my-zsh/plugins/ssh-agent/ssh-agent.plugin.zsh';
source '/Users/alkuzmanov/Documents/Drugi-lichni-neshta-alk19890105/Rabotilnitsa-programirane-alk19890105/dotfiles-alk19890105-v3.0/macos-dotfiles/_antigen/bundles/robbyrussell/oh-my-zsh/plugins/extract/extract.plugin.zsh';
source '/Users/alkuzmanov/Documents/Drugi-lichni-neshta-alk19890105/Rabotilnitsa-programirane-alk19890105/dotfiles-alk19890105-v3.0/macos-dotfiles/_antigen/bundles/robbyrussell/oh-my-zsh/plugins/vi-mode/vi-mode.plugin.zsh';
source '/Users/alkuzmanov/Documents/Drugi-lichni-neshta-alk19890105/Rabotilnitsa-programirane-alk19890105/dotfiles-alk19890105-v3.0/macos-dotfiles/_antigen/bundles/robbyrussell/oh-my-zsh/plugins/command-not-found/command-not-found.plugin.zsh';
source '/Users/alkuzmanov/Documents/Drugi-lichni-neshta-alk19890105/Rabotilnitsa-programirane-alk19890105/dotfiles-alk19890105-v3.0/macos-dotfiles/_antigen/bundles/zsh-users/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh';
source '/Users/alkuzmanov/Documents/Drugi-lichni-neshta-alk19890105/Rabotilnitsa-programirane-alk19890105/dotfiles-alk19890105-v3.0/macos-dotfiles/_antigen/bundles/zsh-users/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh';
source '/Users/alkuzmanov/Documents/Drugi-lichni-neshta-alk19890105/Rabotilnitsa-programirane-alk19890105/dotfiles-alk19890105-v3.0/macos-dotfiles/_antigen/bundles/zsh-users/zsh-completions/zsh-completions.plugin.zsh';
source '/Users/alkuzmanov/Documents/Drugi-lichni-neshta-alk19890105/Rabotilnitsa-programirane-alk19890105/dotfiles-alk19890105-v3.0/macos-dotfiles/_antigen/bundles/superbrothers/zsh-kubectl-prompt/zsh-kubectl-prompt.plugin.zsh';

#--- BUNDLES END
typeset -gaU _ANTIGEN_BUNDLE_RECORD; _ANTIGEN_BUNDLE_RECORD=('https://github.com/robbyrussell/oh-my-zsh.git plugins/git plugin true' 'https://github.com/robbyrussell/oh-my-zsh.git plugins/autojump plugin true' 'https://github.com/robbyrussell/oh-my-zsh.git plugins/ssh-agent plugin true' 'https://github.com/robbyrussell/oh-my-zsh.git plugins/extract plugin true' 'https://github.com/robbyrussell/oh-my-zsh.git plugins/vi-mode plugin true' 'https://github.com/robbyrussell/oh-my-zsh.git plugins/command-not-found plugin true' 'https://github.com/robbyrussell/oh-my-zsh.git plugins/docker plugin true' 'https://github.com/robbyrussell/oh-my-zsh.git plugins/plugin-name plugin true' 'https://github.com/zsh-users/zsh-syntax-highlighting.git / plugin true' 'https://github.com/zsh-users/zsh-autosuggestions.git / plugin true' 'https://github.com/zsh-users/zsh-completions.git / plugin true' 'https://github.com/superbrothers/zsh-kubectl-prompt.git / plugin true')
typeset -g _ANTIGEN_CACHE_LOADED; _ANTIGEN_CACHE_LOADED=true
typeset -ga _ZCACHE_BUNDLE_SOURCE; _ZCACHE_BUNDLE_SOURCE=('/Users/alkuzmanov/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/git' '/Users/alkuzmanov/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/git/git.plugin.zsh' '/Users/alkuzmanov/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/autojump' '/Users/alkuzmanov/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/autojump/autojump.plugin.zsh' '/Users/alkuzmanov/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/ssh-agent' '/Users/alkuzmanov/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/ssh-agent/ssh-agent.plugin.zsh' '/Users/alkuzmanov/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/extract' '/Users/alkuzmanov/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/extract/extract.plugin.zsh' '/Users/alkuzmanov/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/vi-mode' '/Users/alkuzmanov/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/vi-mode/vi-mode.plugin.zsh' '/Users/alkuzmanov/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/command-not-found' '/Users/alkuzmanov/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/command-not-found/command-not-found.plugin.zsh' '/Users/alkuzmanov/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/docker' '/Users/alkuzmanov/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/plugin-name' '/Users/alkuzmanov/.antigen/bundles/zsh-users/zsh-syntax-highlighting//' '/Users/alkuzmanov/.antigen/bundles/zsh-users/zsh-syntax-highlighting///zsh-syntax-highlighting.plugin.zsh' '/Users/alkuzmanov/.antigen/bundles/zsh-users/zsh-autosuggestions//' '/Users/alkuzmanov/.antigen/bundles/zsh-users/zsh-autosuggestions///zsh-autosuggestions.plugin.zsh' '/Users/alkuzmanov/.antigen/bundles/zsh-users/zsh-completions//' '/Users/alkuzmanov/.antigen/bundles/zsh-users/zsh-completions///zsh-completions.plugin.zsh' '/Users/alkuzmanov/.antigen/bundles/superbrothers/zsh-kubectl-prompt//' '/Users/alkuzmanov/.antigen/bundles/superbrothers/zsh-kubectl-prompt///zsh-kubectl-prompt.plugin.zsh')
typeset -g _ANTIGEN_CACHE_VERSION; _ANTIGEN_CACHE_VERSION='v2.2.3'

#-- END ZCACHE GENERATED FILE