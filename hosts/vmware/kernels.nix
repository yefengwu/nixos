{ pkgs }:

{
  python27Kernel = (
    let
      env = (pkgs.python2.withPackages (p: with p; [
        ipykernel
        numpy
        scipy
      ])).override (args: { ignoreCollisions = true; });
    in
    {
      displayName = "Python 2.7";
      argv = [ "${env.interpreter}" "-m" "ipykernel_launcher" "-f" "{connection_file}" ];
      language = "python";
      logo32 = "${env}/${env.sitePackages}/ipykernel/resources/logo-32x32.png";
      logo64 = "${env}/${env.sitePackages}/ipykernel/resources/logo-64x64.png";
    }
  );

  python37Kernel = (
    let
      env = pkgs.python37.withPackages (p: with p; [
        ipykernel
        numpy
        scipy
      ]);
    in
    {
      displayName = "Python 3.7";
      argv = [ "${env.interpreter}" "-m" "ipykernel_launcher" "-f" "{connection_file}" ];
      language = "python";
      logo32 = "${env}/${env.sitePackages}/ipykernel/resources/logo-32x32.png";
      logo64 = "${env}/${env.sitePackages}/ipykernel/resources/logo-64x64.png";
    }
  );

  python38Kernel = (
    let
      env = pkgs.python38.withPackages (p: with p; [
        ipykernel
        numpy
        scipy
        numba
        nixpkgs
      ]);
    in
    {
      displayName = "Python 3.8";
      argv = [ "${env.interpreter}" "-m" "ipykernel_launcher" "-f" "{connection_file}" ];
      language = "python";
      logo32 = "${env}/${env.sitePackages}/ipykernel/resources/logo-32x32.png";
      logo64 = "${env}/${env.sitePackages}/ipykernel/resources/logo-64x64.png";
    }
  );

  cKernel = (
    let
      env = pkgs.python3.withPackages (p: with p; [
        jupyter-c-kernel
      ]);
    in
    {
      displayName = "C";
      argv = [ "${env.interpreter}" "-m" "jupyter_c_kernel" "-f" "{connection_file}" ];
      language = "c";
    }
  );

  rustKernel = {
    displayName = "Rust";
    argv = [ "${pkgs.evcxr}/bin/evcxr_jupyter" "--control_file" "{connection_file}" ];
    language = "Rust";
  };

  rKernel = (
    let
      env = pkgs.rWrapper.override {
        packages = with pkgs.rPackages; [
          IRkernel
          ggplot2
        ];
      };
    in
    {
      displayName = "R";
      argv = [ "${env}/bin/R" "--slave" "-e" "IRkernel::main()" "--args" "{connection_file}" ];
      language = "R";
    }
  );

  ansibleKernel = (
    let
      env = (pkgs.python3.withPackages (p: with p; [
        ansible-kernel
        ansible
      ])).override (args: { ignoreCollisions = true; });
    in
    {
      displayName = "Ansible";
      argv = [ "${env.interpreter}" "-m" "ansible_kernel" "-f" "{connection_file}" ];
      language = "ansible";
    }
  );

  bashKernel = (
    let
      env = pkgs.python3.withPackages (p: with p; [
        bash_kernel
      ]);
    in
    {
      displayName = "Bash";
      argv = [ "${env.interpreter}" "-m" "bash_kernel" "-f" "{connection_file}" ];
      language = "Bash";
    }
  );
}
