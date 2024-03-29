% puts the cylindrical coordinates made by the flux_coordinates function into a .dat file

fieldline_coordinates = rand_fb_fldln_co_T;
fieldlinenumber = 11;
first = 320001;
last  = 340000;

fileID = fopen('SULI21/inputs/input.T17','w');   % opens the file for modification

%INDATA
    % Runtime Parameters
    DELT = 0.9;
    NITER = 5000;
    NSTEP = 200;
    TCON0 = 2;
    NS_ARRAY = [9 29 49 99];
    FTOL_ARRAY = [1E-6 1E-8 1E-10 1E-12];
    % Grid Parameters
    LASYM = 'F';
    NFP = 3;
    MPOL = 11;
    NTOR = 6;
    NZETA = 36;
    PHIEDGE = 0.497070205837336;
    % Free Boundary Parameters
    LFREEB = 'T';
    MGRID_FILE = '''mgrid_c09r00.nc''';
    EXTCUR = [6.52271941985300E+05  6.51868569367400E+05  5.37743588647300E+05...
        2.50000000000000E-07  2.50000000000000E-07  2.80949750000000E+04...
        -5.48049500000000E+04  3.01228950000000E+04  9.42409100000000E+04...
        4.55138737653200E+04];
    NVACSKIP = 6;
    % Pressure Parameters
    GAMMA = 0;
    BLOAT = 1;
    SPRES_PED = 1;
    AM = [6.85517649352426E+04 -5.12027745123057E+03 -3.61510451745464E+04 -4.74263014113066E+05...
        1.78878195473870E+06 -3.21513828868170E+06  2.69041023837233E+06 -8.17049854168367E+05...
        0.00000000000000E+00  0.00000000000000E+00  0.00000000000000E+00];
    % Current/Iota Parameters
    CURTOR = -1.78606250000000E+05;
    NCURR = 1;
    AI = zeros(1,11);
    AC = [8.18395699999999E+03  1.43603560000000E+06 -1.07407140000000E+07  7.44389200000000E+07...
        -3.22215650000000E+08  8.81050800000000E+08 -1.49389660000000E+09  1.52746800000000E+09...
        -8.67901590000000E+08  2.10351200000000E+08  0.00000000000000E+00];
    % Axis Parameters
    RAXIS = [1.49569454253276E+00  1.05806400912320E-01  7.21255454715878E-03 -3.87402652289249E-04...
        -2.02425864534069E-04 -1.62602353744308E-04 -8.89569831063077E-06];
    ZAXIS = [0.00000000000000E+00 -5.19492027001782E-02 -3.18814224021375E-03  2.26199929262002E-04...
        1.28803681387330E-04  1.11266150452637E-06  1.13732703961869E-05];
    % Boundary Parameters
    R_temp = [-6 -5 -4 -3 -2 -1 0 1 2 3 4 5 6];
    R_values = [0 1 2 3 4 5 6, R_temp, R_temp, R_temp, R_temp, R_temp, R_temp, R_temp, R_temp, R_temp, R_temp]';
    Z_values = [repelem([0],7),  repelem([1],13), repelem([2],13), repelem([3],13), repelem([4],13),...
        repelem([5],13), repelem([6],13), repelem([7],13), repelem([8],13), repelem([9],13), repelem([10],13)]';
    RBC = [1.40941668895656E+00 2.79226697269945E-02 -1.54739398509667E-03 2.90733840104882E-03  -8.91322016448873E-04  -7.81997770407839E-05   1.06129711928351E-04  2.48228899767757E-05  8.23567667077671E-05 -7.20220898033597E-04  2.76250777733235E-03 -1.24883373588382E-02  1.52272804511910E-02   2.89195233044040E-01  -1.17988850341728E-01  -3.84923299492945E-03  -1.44452305429529E-03  -2.11622985211109E-04   1.79091719677667E-04   1.31982402741742E-04 -2.40882614870476E-05 -4.92449386382591E-05  1.50530476034115E-04 -1.23084235126550E-03  2.01350576071929E-04  2.36777003797179E-03   5.73443941583452E-02   6.89385874058265E-02   4.71996849673782E-02  -5.50889052720066E-04   4.24491391207156E-04  -2.07538883155595E-04  -1.62304038006678E-04 -1.01105699684233E-04  5.15925605980565E-05 -3.79290487874111E-05 -2.96154201246223E-04  1.27628943631957E-03  3.12803506573940E-03  -1.34574092972690E-02  -8.02339287294677E-03  -1.68510947837154E-02  -8.00581733372124E-03   1.80667899211621E-03   3.10773970094350E-05   8.32496816115997E-05 -1.19874891436340E-05  1.22793444338155E-04 -1.30945484439682E-04 -1.21368603604647E-04  1.00352526472782E-03 -1.73680844498789E-03   1.80149787198970E-03   3.82771889154294E-03   5.43835034437129E-03   8.39729828422411E-04   6.74263596810560E-04  -6.98647584180715E-04   8.77670652920776E-05  6.78635213884316E-06  3.87846546342867E-05 -3.78300368387435E-05 -1.21743926248229E-05 -2.68229697014545E-04  1.19567316567517E-03  -7.12579133390599E-04   8.81127157923892E-04   9.67210453659238E-04   2.11794179698155E-04   1.29403911922840E-03  -1.30477683585083E-04   1.86680624010370E-04 -4.08213549686361E-05  7.11305157811999E-05 -1.33727065581923E-04  1.65191943182183E-06  2.19460449719541E-04  4.68618562605432E-04  -8.51896573200937E-04  -5.26623264534578E-05  -1.31954654361710E-04  -8.91482312658694E-04  -3.89733094884781E-04  -2.74329775462215E-04   2.47385092660320E-04  9.61516193308531E-06 -2.51122684780459E-05  4.44568599556351E-05 -1.42433799354752E-04  4.85802385952487E-04 -9.00652688032426E-04   9.59457670863182E-04  -3.37159659594826E-04  -4.64969900861713E-04  -4.09185322970312E-04   5.32088748759921E-05  -3.21692982976907E-04  -4.82403633897412E-05 -2.23522770283961E-05  3.95696912099304E-05 -6.50775924544567E-05  1.71610112932980E-04 -3.45412623614909E-04  5.61089095467387E-04  -5.84359101746051E-04  -6.16860761080513E-05   5.99275780897287E-04   5.68520162541870E-04   4.47404034542356E-04   2.76704814165950E-04   2.97621090888441E-04 -3.78145897931544E-06 -1.57985677623482E-05  7.91641381274532E-05 -1.97587428419659E-04  3.95855751452672E-04 -5.41153103221438E-04   4.98714381092541E-04  -8.06048953531492E-05  -8.67990109801738E-05   4.35340840113358E-04   2.33585243788111E-04  -7.69581174305243E-06  -2.85256407945938E-05  1.20206720198758E-05  7.02670536357846E-06 -2.76926398374910E-05  5.20223745639364E-05 -7.88310431749746E-05  1.21755712542490E-05  3.22193519645521E-05 -1.08453911913102E-06  1.04051545504927E-04 -5.21965328013036E-04 -4.95991087393098E-04 -1.94520415280627E-04 -6.94143617569942E-05]';
    ZBS = [0.00000000000000E+00 -1.92433268059631E-02 1.11459511078088E-02 -3.97869471888770E-03    1.34394804673514E-03   -1.57143910159387E-04    9.58024291307491E-05  -2.28386224209054E-05   3.30176003890210E-04   1.28038328362904E-04   3.43199911886317E-04   6.12174680232785E-04  -2.70066914159594E-02    4.50462554508443E-01    1.93490230971634E-01    5.72865331625290E-03    2.19788951889214E-03    1.31883972780290E-03   -5.63363462408534E-04   -9.31801467009349E-05  -3.95416405717970E-05  -3.25048356502217E-06   4.61522421935086E-05  -3.40868203306282E-04  -4.19781517712033E-03   1.98753868216412E-02    4.81527027892127E-03   -9.28353553039424E-03   -2.04292782322197E-02    8.81593501270446E-04  -6.08871281835245E-04  -3.88708113241096E-04  1.72340342752605E-04  -6.16215454248342E-05   1.23419431936950E-04   3.98637008165582E-06  -7.01248486620889E-04   3.19332333533202E-03  -8.24657727838880E-03    5.05936199755365E-03   -3.90421394288867E-03    3.75441853342170E-03    6.00542774606014E-03   -4.16787432635077E-04    5.44335921432213E-05   -4.15830451164888E-05   1.56845408711308E-05  -3.97576733690054E-05  -7.22429623460448E-05   3.52928331257216E-04  -1.23710282249961E-04  -1.50689928334813E-03    1.56109492686192E-03    3.80910842862487E-03    2.06275075117804E-03   -1.54779126563731E-03   -1.33149943553452E-03    3.81307095116973E-04   -1.40433963574141E-05  -1.22283666932084E-05   4.64829761643373E-05  -7.03801581329045E-05   1.85735151533626E-04  -9.33216243296025E-04   2.12648562837673E-03   -1.97890515574565E-03    2.71321673191593E-03    8.74618447862515E-04    8.43817701627930E-04    6.51808476607835E-04    1.01349326961770E-04   -2.13838628730300E-04  -7.53394429655583E-06   2.54876062250879E-05  -1.70180862196520E-05  -1.31350577800873E-04   4.38914760402648E-04  -4.44537659614533E-04    7.36122964253313E-04   -1.12352425125337E-03   -2.22905186553194E-03   -2.11193996461398E-03   -3.44184359663702E-04   -5.06914660659672E-05    3.74971583066409E-05  -3.66121037894761E-06   3.72828134065079E-05  -8.74488353626824E-05   1.48694485468843E-04  -2.27519962800893E-04   4.16601324903870E-04   -3.25818663499641E-04   -2.34240245561361E-04    4.87821281121050E-04    8.50140634573578E-04    5.93528572346752E-04   -2.54775193277671E-04    1.41947169759239E-05  -4.00911971000495E-06   1.34684147523625E-05  -2.94168940555405E-05   2.17875987311858E-05  -7.26482153663716E-05   2.51145295676537E-04   -5.42465826224607E-04    3.93697603313273E-04    3.30798770955874E-04    5.47788467933391E-04    2.43547539548605E-04    9.15194583315619E-05    1.65605427353701E-04  -1.85759364750771E-06   1.06970045147331E-05  -1.16252171939772E-05  -3.08457797690412E-05   2.03418980231168E-04  -3.99552958537408E-04    4.32916759100965E-04   -1.84722027458208E-04    2.52568631885491E-04   -3.50159782847442E-04   -7.06133299107118E-04   -3.79072907220561E-04   -4.49599333610498E-05   4.73580005255806E-06  -6.99664911015022E-06  -9.18014408856618E-06   6.80574180383753E-05  -1.06370673487973E-04   1.22161894513591E-04  -6.04052049877600E-05   8.60890353665843E-05  -2.17661420286656E-04  -2.67111216700977E-04   2.43875640076056E-05   1.55759001593971E-04   4.40565098025554E-05]';
    boundary_data = [R_values, Z_values, RBC, R_values, Z_values, ZBS];

% FIELDLINES DATA
    NR = 201;                                       % Number of radial gridpoints
    NZ = 201;                                       % Number of vertical gridpoints
    NPHI = 36;                                      % Number of toroidal gridpoints
    RMIN = 0.5;                                     % Minimum extend of radial grid
    RMAX = 2.0;                                     % Maximum extent of radial grid
    ZMIN = -1.0;                                    % Minimum extent of vertical grid
    ZMAX = 1.0;                                     % Maximum extent of vertical grid
    PHIMIN = 0;
    %PHIMIN = floor(min(fieldline_coordinates(fieldline_number).phi)*10)/10;     % Minimum extent of toroidal grid (overwritten by mgrid or coils file)
    PHIMAX = 2*pi;                                  % Maximum extent of toroidal grid (overwritten by mgrid or coils file)
    MU = 1E-6;                                      % Fieldline diffusion 
    
    
    % Variable start points for R, Z, and PHI
    
    size_r = size(fieldline_coordinates(fieldline_number).r,1);
    arr_index = [1:size_r]';                           % creates an array of indecies
    fieldline_data = [arr_index, fieldline_coordinates(fieldline_number).r, arr_index,...            % creates an array of alternating index columns and coordinate columns
        fieldline_coordinates(fieldline_number).z, arr_index, fieldline_coordinates(fieldline_number).phi];
    
    arr_index = [1:last-first+1]';
    fieldline_data = [arr_index, fieldline_data(first:last,2),...
        arr_index, fieldline_data(first:last,4), arr_index, fieldline_data(first:last,6)];
   
    PHI_END = 6.283E+04;     % Maximum distance in the toroidal direction to follow fieldlines
    NPOINC = 120;                                   % Number of toroidal points per-period to output the field line trajectory
    INT_TYPE = 'LSODE';                             % Fieldline integration method (NAG, RKH68, LSODE)
    FOLLOW_TOL = 1E-9;                              % Fieldline following tollerance
    VC_ADAPT_TOL = 1E-7;
    
% sets up the format for the file to populate
fprintf(fileID, '&INDATA\n');
    % Runtime Parameters
    fprintf(fileID, '!----- Runtime Parameters -----\n');
    fprintf(fileID, '  DELT = %6.2E \n', DELT);
    fprintf(fileID, '  NITER = %4.0f \n', NITER);
    fprintf(fileID, '  NSTEP = %4.0f \n', NSTEP);
    fprintf(fileID, '  TCON0 = %6.2E \n', TCON0);
    fprintf(fileID, '  NS_ARRAY = %4.0f %4.0f %4.0f %4.0f \n', NS_ARRAY);
    fprintf(fileID, '  FTOL_ARRAY = %9.6E %9.6E %9.6E %9.6E\n', FTOL_ARRAY);
    % Grid Parameters
    fprintf(fileID, '!----- Grid Parameters -----\n');
    fprintf(fileID, '  LASYM = %1c \n', LASYM);
    fprintf(fileID, '  NFP = %4.0f \n', NFP);
    fprintf(fileID, '  MPOL = %4.0f \n', MPOL);
    fprintf(fileID, '  NTOR = %4.0f \n', NTOR);
    fprintf(fileID, '  NZETA  = %4.0f \n', NZETA);
    fprintf(fileID, '  PHIEDGE = %4.14E \n', PHIEDGE);
    % Free Boundary Parameters
    fprintf(fileID, '!----- Free Boundary Parameters -----\n');
    fprintf(fileID, '  LFREEB = %1c \n', LFREEB);
    fprintf(fileID, '  MGRID_FILE = %1s \n', MGRID_FILE);
    fprintf(fileID, '  EXTCUR = %22.14E %22.14E %22.14E \n  %22.14E %22.14E %22.14E \n  %22.14E %22.14E %22.14E \n  %22.14E \n', EXTCUR);
    fprintf(fileID, '  NVACSKIP = %4.0f \n', NVACSKIP);
    % Pressure Parameters
    fprintf(fileID, '!----- Pressure Parameters -----\n');
    fprintf(fileID, '  GAMMA = %12.6E \n', GAMMA);
    fprintf(fileID, '  BLOAT = %12.6E \n', BLOAT);
    fprintf(fileID, '  SPRES_PED = %20.14E \n', SPRES_PED);
    fprintf(fileID, '  AM = %22.14E %22.14E %22.14E %22.14E \n %22.14E %22.14E %22.14E %22.14E \n %22.14E %22.14E %22.14E \n', AM);
    % Current/Iota Parameters
    fprintf(fileID, '!----- Current/Iota Parameters -----\n');
    fprintf(fileID, '  CURTOR = %20.14E \n', CURTOR);
    fprintf(fileID, '  NCURR = %4.0f \n', NCURR);
    fprintf(fileID, '  AI = %22.14E %22.14E %22.14E %22.14E \n %22.14E %22.14E %22.14E %22.14E \n %22.14E %22.14E %22.14E \n', AI);
    fprintf(fileID, '  AC = %22.14E %22.14E %22.14E %22.14E \n %22.14E %22.14E %22.14E %22.14E \n %22.14E %22.14E %22.14E \n', AC);
    % Axis Parameters
    fprintf(fileID, '!----- Axis Parameters -----\n');
    fprintf(fileID, '  RAXIS = %22.14E %22.14E %22.14E %22.14E \n %22.14E %22.14E %22.14E \n', RAXIS);
    fprintf(fileID, '  ZAXIS = %22.14E %22.14E %22.14E %22.14E \n %22.14E %22.14E %22.14E \n', ZAXIS);
    % Boundary Parameters
    fprintf(fileID, '!----- Boundary Parameters -----\n');
    fprintf(fileID, '  RBC(%2.0f,%1.0f) = %22.14E    ZBS(%2.0f,%1.0f) = %22.14E \n', boundary_data');
    % FIELDLINES_INPUT
    fprintf(fileID, '/\n');
    fprintf(fileID, '&FIELDLINES_INPUT\n');
    fprintf(fileID, 'NR = %.0f \n', NR);
    fprintf(fileID, 'NZ = %.0f \n', NZ);
    fprintf(fileID, 'NPHI = %.0f \n', NPHI);
    fprintf(fileID, 'RMIN = %.3f \n', RMIN);
    fprintf(fileID, 'RMAX = %.3f \n', RMAX);
    fprintf(fileID, 'ZMIN = %.1f \n', ZMIN);
    fprintf(fileID, 'ZMAX = %.1f \n', ZMAX);
    fprintf(fileID, 'PHIMIN = %.1f \n', PHIMIN);
    fprintf(fileID, 'PHIMAX = %.10f \n', PHIMAX);
    fprintf(fileID, 'MU = %.1d \n', MU);
    fprintf(fileID, 'R_START(%.0d) = %20.12e    Z_START(%.0d) = %20.12e    PHI_START(%.0d) = %20.12e\n', fieldline_data');
    fprintf(fileID, 'PHI_END = %.0d*%.1f \n', size(arr_index,1), PHI_END);
    fprintf(fileID, 'NPOINC = %.0f \n', NPOINC);
    fprintf(fileID, 'INT_TYPE = ''%s'' \n', INT_TYPE);
    fprintf(fileID, 'FOLLOW_TOL = %.1d \n', FOLLOW_TOL);
    fprintf(fileID, 'VC_ADAPT_TOL = %.1d \n', VC_ADAPT_TOL);
    fprintf(fileID, '&END');
%}
    
fclose(fileID); % closes the file
