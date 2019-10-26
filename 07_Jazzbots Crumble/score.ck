// score.ck

// paths
me.dir() + "/bass.ck" => string bassPath;
me.dir() + "/drums.ck" => string drumsPath;
me.dir() + "/piano.ck" => string pianoPath;
me.dir() + "/pad.ck" => string padPath;
me.dir() + "/cabasa.ck" => string cabasaPath;

// cue in cabasa
Machine.add(cabasaPath) => int cabasaID;

// piano plays
8::second => now;
Machine.add(pianoPath) => int pianoID;

// cue in the drums
8::second => now;
Machine.add(drumsPath) => int drumsID;

// bass and pad
4::second => now;
Machine.remove(cabasaID);
Machine.add(padPath) => int padID;
Machine.add(bassPath) => int bassID;

// stop the drums
24::second => now;
Machine.remove(pianoID);
8::second => now;
Machine.remove(drumsID);
14::second => now;
Machine.remove(padID);

// bang again
2::second => now;
Machine.add(drumsPath) => drumsID;
Machine.add(cabasaPath) => cabasaID;
Machine.add(padPath) => padID;
Machine.add(pianoPath) => pianoID;

24::second => now;
Machine.remove(pianoID);
Machine.remove(drumsID);
Machine.remove(padID);
Machine.remove(bassID);

4::second => now;
Machine.remove(cabasaID);
