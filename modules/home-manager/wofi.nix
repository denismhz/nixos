{
  config,
  pkgs,
  ...
}: {
  wofi = {
    enable = true;
    settings = {
      normal_window = true;
      matching = "fuzzy";
      insensitive = true;
      sort_order = "alphabetical";
      monitor = "HDMI-A-1";
    };
    style = ''
      * {
          all: unset;
          font-family: "JetBrainsMono";
          font-size: 16px;
      }

      #window {
          background-color: #292a37;
      }

      #input{
          margin: 1rem;
          padding: 0.5rem;
          border-radius: 10px;
          background-color: #303241;
      }

      #entry {
          margin: 0.25rem 0.75rem 0.25rem 0.75rem;
          padding: 0.25rem 0.75rem 0.25rem 0.75rem;
          color: #9699b7;
          border-radius: 3px;
      }

      #entry:selected {
          background-color: #303241;
          color: #d9e0ee;
      }
    '';
  };
}
