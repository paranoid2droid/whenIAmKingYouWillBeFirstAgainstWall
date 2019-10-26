<<< "Zhe Zhang" >>>;

// title: 30 seconds Panic Attack!
// a panic attack occuring on a paranoid android
// Created by Zhe
// 2018.9.22

// patch and initialize the generator
Pan2 pan => dac;

SinOsc sin => pan;
.3/11 => sin.gain;

TriOsc tri => pan.left;
.06/11 => tri.gain;

SawOsc saw => pan.right;
.03/11=> saw.gain;
22.5 => saw.freq;

// initialize the period value
12 => float t;

// loop
while(1){
    
    // if the period is too short then make a kind of crumbling sound
    // for 5 seconds
    if ( t < .00000000002 ) {
        // control the length of this sound
        for ( 0 => int k; k < 1000; k++){
            // use random function to make noisy sound
            Math.random2(3200, 6400) => sin.freq;
            Math.random2(40, 3200) => saw.freq;
            // frequency changing rate
            10::ms => now;
        }
        // reset the period value and initial pitch
        5 => t;
        22.5 => saw.freq;
    }
    
    // Chuck the period value to the period    
    t::second => dur period;
    
    // monitor the priod in the console
    <<< period / second >>>;
    
    // reset the sin pitch when every loop begins
    110 => sin.freq;    
    
    // set the top and the bottom of the slide sound
    4200 => float slide;
    // control the slide speed and length
    for ( 0 => int i; i<176; i++){
        // set the initial pitch
        slide => tri.freq;
        // slide downwards
        20 -=> slide;
        // set the rate
        .002::period => now;
    } 

    // make another ringing sound
    for ( 0 => int j; j<50; j++){
        // every 7 times change the pitch
        if ( j%7 ){
            220 => saw.freq;
            1760 => sin.freq;
        }
        else{
            440*0.8 => sin.freq;
            880*1.2 => saw.freq;
        } 
        // set the rate       
        .01::period => now;
        
        // reset the saw pitch
        55 => saw.freq;
    }
    
    // incresing the speed of the sound
    t/5*4 => t;    
}