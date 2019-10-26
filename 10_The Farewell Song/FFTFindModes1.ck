// Modal Peak Identification/Extraction Lab 1
// by Perry R. Cook, July 2015, updated Mar 2016.
// A few things to fiddle with in here. 
// First, the File you're analyzing, put in your filename here.
//       "PlatePlink.wav" => string fileName;  // we used this in class

"MyModalObject.wav" => string fileName;      // your modal sound file
//  "MYWAVEFILE.wav" => string fileName;      // your modal sound file

// If you provide an argument, as in chuck FFTFindModes.ck:MyModalObject.wav
if (me.args()) me.arg(0) => fileName; // arg overwrites it

// Then NUM_PEAKS, not too many, but more than a few
// You can change this as you like, experiment, and/or
// throw out extra peaks at the end
20 => int NUM_PEAKS;

int peakloc[NUM_PEAKS];
float peaks[NUM_PEAKS];
16 => int LOBE;  // window (sine) main lobe 1/2 width

SndBuf in => FFT fft => blackhole;   // draw samples through FFT
me.dir()+fileName => in.read;   //  Define fileName at top

if (in.samples() < 1)  me.exit();  // check to see if we loaded a soundfile

16384 => int SIZE;    // pretty big FFT = fairly good freq accuracy
float histo[SIZE/2];

// complex Z[SIZE/2];  // this is for our residue synthesis later
// IFFT ifft => WvOut residue => blackhole; // for writing out residue later

Windowing.blackmanHarris(SIZE/4) => fft.window;
SIZE => fft.size;

UAnaBlob blob;
float max,peak,norm,power,floor;
int numBufs;

<<< "Extracting", NUM_PEAKS, "Peaks from file", fileName >>>;
<<< "Lobe Width will forbid any modes closer than", (second/samp)*LOBE/SIZE, "Hz" >>>;

in.samples()/(SIZE/8) => int NUM_FRAMES; // frame counter MAX

//  while (in.pos() < in.samples())	{
for (int i; i < NUM_FRAMES; i++)  {
    (SIZE/8) :: samp => now;		// Hop size
    fft.upchuck() @=> blob;		// Compute and
    blob.fvals() @=> float mag_spec[];	//     average spectrum
    for (0 => int i; i < SIZE/2; i++)	{
        mag_spec[i]*mag_spec[i] +=> histo[i];
    }
    numBufs++;
}

//  Apply 1/sqrt(f) preemphasis "filter)
// You can hack this to be i*i *=> for 1/f
// or change it to something else, or comment it out.
//  Controls how much to favor high vs. low peaks
for (0 => int i; i < SIZE/2; i++)  {
    i *=> histo[i];
}
    
// Find Peaks in HF emphasized histogram
0 => int pk;

while (pk < NUM_PEAKS)  {
    0.0 => peak;
    -1 => peakloc[pk];
    for (0 => int i; i < SIZE/2; i++)	{        
        if (histo[i] > peak) {
            histo[i] => peak;
            i => peakloc[pk];
        }
    }
    peak / peakloc[pk] => peak;
    if (pk == 0) peak => norm;
    peak/norm => peaks[pk];
    <<< "Peak", pk, peaks[pk], (second/samp)*peakloc[pk]/SIZE >>>;
//    peaks[pk]*peaks[pk]/(peakloc[pk]*peakloc[pk]) +=> power;  // keep track of power in peaks
    peaks[pk]*peaks[pk]/peakloc[pk] +=> power;  // keep track of power in peaks
    zeroOut(histo,peakloc[pk]);
    pk++;
}

0.0 => floor;
for (1 => int i; i < SIZE/2; i++)	{  // add up power in residue
    histo[i] / norm / i => histo[i] => float temp;
    temp*temp +=> floor;
}

<<< "Pass1: Full file, Emphasized, Power in peaks=", power >>>;
<<< "Pass1: Full file, Emphasized, Power in residue=", floor >>>;

//  OK, now we take another pass, only looking at the max value of each peak
//  We also not the time when that bin drops down 40dB from the peak
//  We print this as a time, and as a radius for an exponential decay

0 => in.pos;  // reset our soundfile to play again
// zero out our histogram, we'll now use it to keep peaks of peaks
for (0 => int i; i < SIZE/2; 1 +=> i)  0.0 => histo[i];

(SIZE/4) :: samp => now;		// "Preroll" a little

//  while (in.pos() < in.samples())	{
for (int i; i < NUM_FRAMES; i++)  {
    (SIZE/8) :: samp => now;		// Hop size
    fft.upchuck() @=> blob;		// Compute and
    blob.fvals() @=> float mag_spec[];	//     average spectrum
    for (0 => pk; pk < NUM_PEAKS; pk++)	{
        mag_spec[peakloc[pk]] => float temp;
        if (temp > histo[peakloc[pk]]) 
            temp => histo[peakloc[pk]];
        if (temp > max) temp => max;
    }
}

//   Print out these new results, sorted by new peak level
<<< "******Pass 2:  Maximum of each peak across full file","******" >>>;

sortPeaks();  // put everybody in order

for (0 => pk; pk < NUM_PEAKS; pk++)  {
    histo[peakloc[pk]]/max => peaks[pk];
    <<< "[",(second/samp)*peakloc[pk]/SIZE,",",peaks[pk],"]," >>>;
}
    
// OK, we're all done!!!
<<< "Thanks for using ModeExtractLab!!", "Please Drive Through...\n" >>>;
<<< "PS: You'll need to dress up the mode array a little:","" >>>;
<<< "(add [ and ], delete last comma.  You can also experiment","" >>>;
<<< "with which modes matter the most, you can throw some out.","\n" >>>;

fun void squelchComplex(complex array[], int loc)  {
    loc-LOBE => int mn; if (mn < 0) 0 => mn;
    loc+LOBE => int mx; if (mx > SIZE/2) SIZE/2 => mx;
    loc-LOBE-4 => int leftFloor; 
    if (leftFloor < 0) 0 => leftFloor;
    loc+LOBE+4 => int riteFloor; 
    if (riteFloor > SIZE/2) SIZE/2-1 => riteFloor;

    (array[leftFloor]$polar).mag => float targ;
    if ((array[leftFloor]$polar).mag < targ) 
        (array[riteFloor]$polar).mag => float targ;    
    while (mn < mx)  {
        targ / (array[mn]$polar).mag => float norm;
        norm *=> array[mn];
        mn++;
    }
}

fun void zeroOut(float array[],int loc)  {
    loc-LOBE => int mn; if (mn < 0) 0 => mn;
    loc+LOBE => int mx; if (mx > SIZE/2) SIZE/2 => mx;

    while (mn < mx)  {
        0 => array[mn];
        mn++;
    }
}

fun void sortPeaks()  {  // slow sort, I know, but not that many items
    1 => int notDone;
    while (notDone)  {
        0 => notDone;
        for (0 => pk; pk < NUM_PEAKS-1; pk++)  {
            if (peaks[pk+1] > peaks[pk])  {  // the old shell game
                1 => notDone;
                peakloc[pk] => int tp;
                peaks[pk] => float tmp;
                peakloc[pk+1] => peakloc[pk];
                peaks[pk+1] => peaks[pk];
                tp => peakloc[pk+1];
                tmp => peaks[pk+1];
            }
        }
    }
}
