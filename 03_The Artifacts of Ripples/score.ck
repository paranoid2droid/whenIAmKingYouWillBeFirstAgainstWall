// score.ck

// declare
BPM tempo;
SCALE player;

// set the parameters w/ classes used
tempo.tempo(60);
player.setTonic("C");
player.setScale("Ionian");
player.setOctave( 0 );

// paths to chuck file
me.dir() + "/bass.ck" => string bassPath;
me.dir() + "/drums.ck" => string drumsPath;
me.dir() + "/arp.ck" => string arpPath;
me.dir() + "/OceanMachine/Shore.ck" => string shorePath;
me.dir() + "/OceanMachine/Ocean.ck" => string oceanPath;

// start ocean
Machine.add(shorePath) => int wavesID;
10::second => now;

// start drums
Machine.add(drumsPath) => int drumsID;
Machine.add(bassPath) => int bassID;
6::second => now;

Machine.add(arpPath) => int arpID;
14::second => now;

// remove drums
tempo.tempo(30);
player.setTonic("E");
player.setScale("Dorian");
player.setOctave( -2 );
Machine.remove(bassID);
8::second => now;

// change tempo and scale
// cue drums
tempo.tempo(120);
player.setTonic("G");
player.setScale("Mixolydian");
player.setOctave( 3 );
Machine.remove(drumsID);
8::second => now;

// out and in
Machine.remove(wavesID);
Machine.add(bassPath) => bassID;
Machine.add(drumsPath) => drumsID;
8::second => now;

//change again
tempo.tempo(60);
player.setTonic("C");
player.setScale("Aeolian");
player.setOctave( -1 );
12::second => now;

Machine.remove(bassID);
Machine.add(oceanPath) => int oceanID;
8::second => now;

Machine.remove(drumsID);
8::second => now;

Machine.remove(arpID);
8::second => now;

Machine.remove(oceanID);