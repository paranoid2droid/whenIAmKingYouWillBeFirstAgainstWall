// score.ck

// declare the public classes
BPM tempo;
SCALE player;

// paths to chuck file
me.dir() + "/bass.ck" => string bassPath;
me.dir() + "/drums.ck" => string drumsPath;
me.dir() + "/arp.ck" => string arpPath;
me.dir() + "/cabasa.ck" => string cabasaPath;
me.dir() + "/mandolin.ck" => string mandolinPath;

// composing start

// set tempo and scale and octave
tempo.tempo(60);
player.setTonic("G");
player.setScale("Ionian");
player.setOctave( -1 );

// start with cabasa and moog sound
Machine.add(cabasaPath) => int cabasaID;
8::second => now;

// cue in arp
Machine.add(arpPath) => int arpID;
8::second => now;

// cue in drums
Machine.add(drumsPath) => int drumsID;
8::second => now;

// change scale
Machine.add(bassPath) => int bassID;
tempo.tempo(60);
player.setTonic("B");
player.setScale("Ionian");
player.setOctave( -1 );
8::second => now;

// harmony progressing
tempo.tempo(60);
player.setTonic("C");
player.setScale("Ionian");
player.setOctave( 0 );
8::second => now;

// going on
tempo.tempo(60);
player.setTonic("C");
player.setScale("Aeolian");
player.setOctave( 0 );
Machine.remove(bassID);
Machine.remove(drumsID);
8::second => now;

// dark section
tempo.tempo(30);
player.setTonic("Ab");
player.setScale("Dorian");
player.setOctave( -2 );
Machine.add(mandolinPath) => int mandolinID;
8::second => now;

// kinda crazy part
tempo.tempo(120);
player.setTonic("G");
player.setScale("Mixolydian");
player.setOctave( 1 );
8::second => now;

// drum
Machine.remove(arpID);
Machine.remove(cabasaID);
Machine.add(drumsPath) => drumsID;
4::second => now;

// speed
tempo.tempo(180);
Machine.remove(mandolinID);
4::second => now;

// up
tempo.tempo(240);
4::second => now;

// back to the main hormony progress
tempo.tempo(60);
player.setTonic("G#");
player.setScale("Ionian");
player.setOctave( -1 );
Machine.add(arpPath) => arpID;
Machine.add(cabasaPath) => cabasaID;
Machine.add(mandolinPath) => mandolinID;
Machine.add(bassPath) => bassID;
8::second => now;

tempo.tempo(60);
player.setTonic("B#");
player.setScale("Ionian");
player.setOctave( 0 );
8::second => now;

tempo.tempo(60);
player.setTonic("C#");
player.setScale("Ionian");
player.setOctave( 0 );
8::second => now;

tempo.tempo(60);
player.setTonic("C#");
player.setScale("Aeolian");
player.setOctave( 0 );
8::second => now;

tempo.tempo(30);
player.setTonic("G");
player.setScale("Ionian");
player.setOctave( -1 );
8::second => now;

// fade out
Machine.remove(mandolinID);
1::second => now;

Machine.remove(drumsID);
1::second => now;

Machine.remove(arpID);
1::second => now;

Machine.remove(bassID);
3::second => now;

Machine.remove(cabasaID);

