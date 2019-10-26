// A Techno by Zhe Zhang;
// Otc. 2018

// patch channels
SndBuf kick => dac;
SndBuf snare => Pan2 snpan => dac;
SndBuf hihat => Pan2 hhpan => dac;
SndBuf click => Pan2 ckpan => dac;
// make a group for the claps
SndBuf clap1 => Pan2 clpan1 => Gain clmix => dac;
SndBuf clap2 => Pan2 clpan2 => clmix;
SndBuf clap3 => Pan2 clpan3 => clmix;
SndBuf fx1 => dac;
SndBuf fx2 => dac;

.3 => clmix.gain;

// use a pulse oscillator for lead
PulseOsc pulse => Pan2 pulsepan => dac;
.022 => pulse.gain;

// a Dodrian scale prepared for the lead
[60, 62, 63, 65, 67, 69, 70, 72] @=> int lead[];

// load the samples
me.dir(-1) + "/audio/kick_02.wav" => kick.read;
me.dir(-1) + "/audio/snare_02.wav" => snare.read;
me.dir(-1) + "/audio/hihat_02.wav" => hihat.read;
me.dir(-1) + "/audio/click_02.wav" => click.read;
me.dir(-1) + "/audio/clap_01.wav" => clap1.read;
me.dir(-1) + "/audio/clap_01.wav" => clap2.read;
me.dir(-1) + "/audio/clap_01.wav" => clap3.read;
me.dir(-1) + "/audio/stereo_fx_03.wav" => fx1.read;
me.dir(-1) + "/audio/stereo_fx_04.wav" => fx2.read;

// set the gains and fixed pan of samples
kick.samples() => kick.pos;
.8 => kick.gain;

snare.samples() => snare.pos;
.6 => snpan.pan;

hihat.samples() => hihat.pos;
-0.5 => hhpan.pan;

click.samples() => click.pos;
.2 => click.gain;

clap1.samples() => clap1.pos;
-1 => clpan1.pan;

clap2.samples() => clap2.pos;
0 => clpan1.pan;

clap3.samples() => clap3.pos;
1 => clpan3.pan;

fx1.samples() => fx1.pos;
.5 => fx1.gain;

fx2.samples() => fx2.pos;
.2 => fx2.gain;

// a counter for get the beat and the bar
0 => int counter;

// infinite loop
16 => int loop;
//while(1){
for( 0 => int l; l<loop*64+1; l++ ){
    <<< counter >>>;
    // use module and cast to get the beat and bar number
    // a 16-step sequencer
    counter % 16 => int halfbeat;
    counter / 16 $ int => int bar;
    
    // modulate the pulse width to get a dynamic tone
    ( .5 + Math.random2f (-.2, .2 ) )=> pulse.width;
    
    // every half-beat the click moves from center to right
    // and the frequency rises, making a fx
    halfbeat/2 => click.rate;
    halfbeat/16 => ckpan.pan;
    0 => click.pos;
    
    // hi-hat on eighth notes and cued in the 4th bar
    if ( (halfbeat % 2 - 1) && ( bar > 3) ){
        // make every hi-hat beat different
        Math.random2f( 0.1, 0.2 ) => hihat.gain;
        Math.random2f( 0.9, 1.1 ) => hihat.rate;
        0 => hihat.pos;
    }
    
    // kick on 1 and 4 and pull back lead to the tonic
    if( ( halfbeat == 0 )||( halfbeat == 8 ) ){
        0 => kick.pos;
        0 => pulsepan.pan;
        Std.mtof( lead[0] )=> pulse.freq;
    }
    
    // randomly play the Dorian scale and pan on left side
    if( halfbeat == 2 ){
        // monitor the bar going
        <<< "bar", bar >>>;
        hihat.samples() / 10 => hihat.pos;
        Math.random2f( -.9, -.2 ) => pulsepan.pan;
        Math.random2( 0, lead.cap()-1 ) => int temp;
        Std.mtof( lead[temp] )=> pulse.freq;
    }
    
    // snare!
    if( halfbeat == 4 && ( bar > 1) ){        
        0 => snare.pos;
        1 => snare.rate;
    }
    
    // on this beat plays the pad aka. fx1
    if( halfbeat == 6){
        if( bar > 5 ){
            1 => fx1.rate;
            // 4 bar a phrase
            if ( bar % 4 == 1 ){
                fx1.samples() / 3 => fx1.pos;
                1.25 => fx1.rate;}
            // and change the pitch of fx1 in the phrase
            if ( bar % 4 == 3 ){
                fx1.samples()/2 => fx1.pos;
                0.8 => fx1.rate;}
                
            0 => fx1.pos;
            }
    }
    
    // snare and claps after 4th bar!
    if( halfbeat == 12 && ( bar > 2) ){
        hihat.samples() / 10 => hihat.pos;
        
        .8 => snare.rate;
        0 => snare.pos;
        
        Math.random2f( 0.7, 0.8 ) => clap1.gain;
        0 => clap1.pos;
        Math.random2f( 0.4, 0.5 ) => clap1.gain;
        0 => clap2.pos;
        Math.random2f( 0.2, 0.3 ) => clap1.gain;
        0 => clap3.pos;
    }
    
    // a reversed fx2 for bass, every 4 bar rings one
    if( (halfbeat == 14) && (bar % 4 == 0) ){
        fx2.samples() / 2 => fx2.pos;
        -1 => fx2.rate;       
        }
        
    // as the song gose on, add some varians on lead
    // also in the Dorian scale but different rhythm
    if( (halfbeat == 15) && (bar > 6) ){
        Math.random2f( .2, .8 ) => pulsepan.pan;
        Math.random2( 0, lead.cap()-1 ) => int temp;
        Std.mtof( lead[temp] )=> pulse.freq;        
    }
    
    // increase counter
    counter++;
    
    // 100ms for 1/16 note
    100::ms => now;
}

500::ms => now;