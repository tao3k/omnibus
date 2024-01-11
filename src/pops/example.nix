{ POP }:
let
  pop = POP;
  # Base POP object representing a generic device
  devicePop = pop.pop {
    name = "devicePop";
    extension = self: super: {
      powerOn = "Generic device powering on";
      powerOff = "Generic device powering off";
    };
  };

  # Specialized POP for a computer
  computerPop = pop.pop {
    name = "computerPop";
    supers = [ devicePop ];
    extension = self: super: {
      powerOn = "Computer booting up";
      startOS = "Operating System starting";
    };
  };

  # Another specialized POP for a smartphone
  smartphonePop = pop.pop {
    name = "smartphonePop";
    supers = [ devicePop ];
    extension = self: super: {
      powerOn = "Smartphone turning on";
      startOS = "Mobile OS starting";
      makeCall = "Making a phone call";
    };
  };

  # Advanced POP for a gaming computer, inheriting from computerPop
  gamingComputerPop = pop.pop {
    name = "gamingComputerPop";
    supers = [ computerPop ];
    extension = self: super: {
      powerOn = super.powerOn + " test";
      startOS = "Gaming OS booting";
      startGame = "Starting a game";
    };
  };

  # Combined POP for a smart gaming device, inheriting from both gamingComputerPop and smartphonePop
  smartGamingDevicePop = pop.pop {
    name = "smartGamingDevicePop";
    supers = [
      gamingComputerPop
      smartphonePop
    ];
    extension = self: super: {
      powerOn = super.powerOn + " Smart Gaming Device powering on";
      startOS = "Smart Gaming OS starting";
      activateVRMode = "Activating VR mode";
    };
  };
in
smartGamingDevicePop
