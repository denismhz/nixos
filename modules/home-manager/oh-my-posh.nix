{ config, pkgs, ... }:
{
  oh-my-posh = {
    enable = true;
    enableBashIntegration = true;
    settings = builtins.fromJSON ''
      {
        "$schema": "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/schema.json",
        "console_title_template": "{{.UserName}}@{{.HostName}} {{.Shell}} in {{.PWD}}", 
        "blocks": [
          {
            "alignment": "left",
            "segments": [
              {
                "background": "#6272a4",
                "foreground": "#ffffff",
                "leading_diamond": "\ue0b6",
                "properties": {
                  "template": "\uF313 {{ .UserName }} "
                },
                "style": "diamond",
                "type": "session"
              },
              {
                "background": "#bd93f9",
                "foreground": "#000000",
                "powerline_symbol": "\ue0b0",
                "properties": {
                  "style": "folder",
                  "template": " {{ .Path }} "
                },
                "style": "powerline",
                "type": "path"
              },
              {
                "background": "#ffb86c",
                "background_templates": [
                  "{{ if or (.Working.Changed) (.Staging.Changed) }} {{ end }}",
                  "{{ if and (gt .Ahead 0) (gt .Behind 0) }} {{ end }}",
                  "{{ if gt .Ahead 0 }} {{ end }}",
                  "{{ if gt .Behind 0 }} {{ end }}"
                ],
                "foreground": "#000000",
                "powerline_symbol": "\ue0b0",
                "properties": {
                  "branch_icon": "\ue725 ",
                  "fetch_status": true,
                  "fetch_upstream_icon": true
                },
                "style": "powerline",
                "template": " {{ .UpstreamIcon }}{{ .HEAD }}{{if .BranchStatus }} {{ .BranchStatus }}{{ end }}{{ if .Working.Changed }} \uf044 {{ .Working.String }}{{ end }}{{ if and (.Working.Changed) (.Staging.Changed) }} |{{ end }}{{ if .Staging.Changed }}<#ef5350> \uf046 {{ .Staging.String }}</>{{ end }} ",
                "type": "git"
              },
              {
                "background": "#8be9fd",
                "foreground": "#000000",
                "powerline_symbol": "\ue0b0",
                "properties": {
                  "template": " \ue718 {{ if .PackageManagerIcon }}{{ .PackageManagerIcon }} {{ end }}{{ .Full }} "
                },
                "style": "powerline",
                "type": "node"
              }
            ],
            "type": "prompt"
          }
        ],
        "final_space": true,
        "version": 1
      }
    '';
  };
}
