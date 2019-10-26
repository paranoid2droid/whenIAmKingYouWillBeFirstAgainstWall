//  Waves beside a shore


10 => int MAX;
Wave waves[MAX];
int shreds[MAX];

0 => int num;

while (num < MAX)  {
   1 => shreds[num];
   spork ~ oneWave(num);
   num++;
   Math.random2f( 1, 3 ) => float temp;
   temp::second => now;
}

// diminish one, add one
while (1)  {
    Math.random2( 0, MAX-1 ) => int one;
    0 => shreds[one];
    Math.random2f( 1, 3 ) => float temp;
    temp::second => now;    
    1 => shreds[one];
    spork ~ oneWave(one);
}

fun void oneWave(int which)  {
    // every wave acts different
    while (shreds[which]) {
        Math.random2f( 600, 1500 ) => float a;
        Math.random2f( 200, 700 ) => float d;
        Math.random2f( 0, 0.7 ) => float s;
        Math.random2f( 200, 600 ) => float r;
        
        waves[which].setADSR( a::ms, d::ms, s, r::ms);
        waves[which].swell();
    }
}
