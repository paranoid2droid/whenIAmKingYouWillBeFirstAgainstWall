// cabasa.ck
// two shakers
Shakers cabasa[2];
// stereo!
cabasa[0] => NRev r1 => dac.left;
cabasa[1] => NRev r2 => dac.right;
1 => cabasa[0].preset;
1 => cabasa[1].preset;
.42 => r1.mix;
.42 => r2.mix;

BPM tempo;

// a function sporked for modulation
spork ~ moving();
// loop
while( true ){
    0 => int count;
    for( 0 => int i; i<2; i++ ){
        // left and right
        Math.random2f(.2, .3) => cabasa[i].energy;
        if ( count%4 == 0 ) .8 => cabasa[i].decay;
        else .2 => cabasa[i].decay;
        cabasa[i].noteOn;
        tempo.eighthNote => now;
        // swing
        if( Math.random2f(0, 1) > 0.618 )
        Math.random2(1, 3) * tempo.eighthNote => now;
    }
    count++;

}

// change the reverb mix so that the shaker moves far and near
fun void moving(){
    while( true ){
        if( Math.random2f(0, 1) > 0.618 ){
            Math.random2f(.36, .42) => r1.mix;
            Math.random2f(.22, .66) => r2.mix;
            .25::second => now;
        }
    }
}
    
        