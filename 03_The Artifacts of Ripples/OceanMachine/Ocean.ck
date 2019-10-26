//  Waves far way

3 => int MAX;
Wave waves[MAX];
int shreds[MAX];

0 => int num;

while (num < MAX)  {
   1 => shreds[num];
   spork ~ oneWave(num);
   num++;
   Math.random2f( 2, 6 ) => float temp;
   temp::second => now;
}

// diminish

0 => int dim;
while (dim < MAX)  {
   0 => shreds[dim];
   dim++;
   Math.random2f( 2, 6 ) => float temp;
   temp::second => now;
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
