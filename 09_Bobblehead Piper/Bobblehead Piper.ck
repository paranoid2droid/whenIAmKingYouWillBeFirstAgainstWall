<<< "Zhe Zhang" >>>;

// two public classes used here
// Add all classes here!
me.dir() + "/BPM.ck" => string BPMPath;
Machine.add(BPMPath);
me.dir() + "/SCALE.ck" => string SCALEPath;
Machine.add(SCALEPath);

// add score.ck
me.dir() + "/score.ck" => string scorePath;
Machine.add(scorePath);
