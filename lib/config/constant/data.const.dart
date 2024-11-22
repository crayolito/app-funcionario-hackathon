import 'package:app_sw1final/config/blocs/auth/auth_bloc.dart';
import 'package:app_sw1final/config/blocs/map/map_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const List<LatLng> coordinates1 = [
  LatLng(-17.77664508875486, -63.206805743040775),
  LatLng(-17.774505008288337, -63.207068283710996),
  LatLng(-17.77660249518011, -63.203831182577815),
  LatLng(-17.776112236560348, -63.200270954251565),
  LatLng(-17.774326838564566, -63.203034857800446),
  LatLng(-17.770844585426634, -63.20514612824836),
  LatLng(-17.774504956394626, -63.208099645546774),
];

const List<LatLng> coordinates2 = [
  LatLng(-17.780438457661678, -63.21488761817528),
  LatLng(-17.78253360626925, -63.21258838222468),
  LatLng(-17.781775505730863, -63.215399724517745),
];

const List<LatLng> coordinates3 = [
  LatLng(-17.76874425231815, -63.20768066588056),
  LatLng(-17.767536144121127, -63.206745617141046),
  LatLng(-17.766598739489456, -63.20590064334945),
  LatLng(-17.76771735061222, -63.20552348209671),
];

const List<LatLng> coordinates4 = [
  LatLng(-17.766860622858136, -63.17655265858137),
  LatLng(-17.76792931876527, -63.17348189209614),
  LatLng(-17.76697349728784, -63.17141492729691),
  LatLng(-17.76534239180337, -63.175607603364796),
  LatLng(-17.76478042138501, -63.17141475667435),
  LatLng(-17.763205629109624, -63.17419017708073),
  LatLng(-17.761236652869506, -63.169408885513995),
];

const List<LatLng> coordinates5 = [
  LatLng(-17.76916767553685, -63.15222018869708),
  LatLng(-17.77153169338991, -63.149145019221955),
  LatLng(-17.772600872207423, -63.15174567615964),
  LatLng(-17.77226514856794, -63.14801759452345),
  LatLng(-17.76978699571016, -63.148022207934105),
  LatLng(-17.769505585547968, -63.14772672056941),
  LatLng(-17.771362028747006, -63.152456280692256),
  LatLng(-17.774120636246483, -63.152158984427956),
];

const List<LatLng> coordinates6 = [
  LatLng(-17.759206877369092, -63.15747809379649),
  LatLng(-17.757968666774786, -63.15487794098482),
  LatLng(-17.759150582861004, -63.15647348676088),
  LatLng(-17.759263129879265, -63.15600072611732),
  LatLng(-17.759263049985158, -63.153518729256795),
  LatLng(-17.75543614036851, -63.15735993613703),
  LatLng(-17.76187329904606, -63.15966991745102),
];

const List<LatLng> coordinates7 = [
  LatLng(-17.78631676164375, -63.14870864164853),
  LatLng(-17.78732034532207, -63.151097391714316),
  LatLng(-17.784711078043276, -63.14913019319857),
  LatLng(-17.782890087792374, -63.15225918295244),
  LatLng(-17.781868777223938, -63.14842775372377),
  LatLng(-17.780930267924862, -63.148180070919395),
  LatLng(-17.781065336923447, -63.15060751477566),
];

const List<LatLng> coordinates8 = [
  LatLng(-17.815499199564734, -63.1517065792178),
  LatLng(-17.815330399257117, -63.15212028826505),
  LatLng(-17.814092431089364, -63.14810151754127),
  LatLng(-17.812460648664402, -63.14863354065939),
  LatLng(-17.8120641385035, -63.1538348355815),
  LatLng(-17.811504149627712, -63.15141124325053),
];

const List<LatLng> coordinates9 = [
  LatLng(-17.79867571546095, -63.1578527711345),
  LatLng(-17.799745754227096, -63.15430772098454),
  LatLng(-17.801939317628513, -63.157084114545846),
  LatLng(-17.80210790649991, -63.15371642420295),
  LatLng(-17.79991348894557, -63.15123430456176),
  LatLng(-17.79726909382872, -63.155016307795485),
  LatLng(-17.798788251581534, -63.156789096609515),
];

const List<LatLng> coordinates10 = [
  LatLng(-17.81306025746571, -63.20259114174168),
  LatLng(-17.814597628013903, -63.20097658322898),
  LatLng(-17.80951789462384, -63.20357334244574),
  LatLng(-17.8101871179989, -63.19627180571955),
  LatLng(-17.80731293068772, -63.19971150882187),
  LatLng(-17.809385048745312, -63.19711413577011),
  LatLng(-17.807112137349243, -63.201747606102295),
  LatLng(-17.81453082782838, -63.2006255123638),
];

const List<LatLng> coordinates11 = [
  LatLng(-17.8168740564937, -63.17493282501389),
  LatLng(-17.816672096314395, -63.17619632540234),
  LatLng(-17.818341317122716, -63.17802099401762),
  LatLng(-17.818345246465014, -63.17465201132484),
  LatLng(-17.814065064872157, -63.178653273981006),
  LatLng(-17.815938255753796, -63.175494584017),
];

const List<LatLng> coordinates12 = [
  LatLng(-17.80323923150819, -63.18875444512581),
  LatLng(-17.805042664579666, -63.190650003443444),
  LatLng(-17.80644566150823, -63.18959841188687),
  LatLng(-17.805710455259803, -63.186302972715914),
  LatLng(-17.803772165282968, -63.189812424263245),
  LatLng(-17.80410836489623, -63.18805060670108),
  LatLng(-17.805444270293496, -63.18805069162501),
];

const List<LatLng> coordinates13 = [
  LatLng(-17.742414919268807, -63.190978992892106),
  LatLng(-17.743172160728207, -63.19008475101518),
  LatLng(-17.742037926255406, -63.185815144090114),
  LatLng(-17.749130570894945, -63.18848597457982),
  LatLng(-17.745349421095337, -63.1854144021567),
  LatLng(-17.740429749023132, -63.186118506158756),
  LatLng(-17.73853573973023, -63.18660831356533),
];

const List<LatLng> coordinates14 = [
  LatLng(-17.72878395880683, -63.171915465845714),
  LatLng(-17.729736961215995, -63.169016888737275),
  LatLng(-17.729636387807478, -63.17251222583498),
  LatLng(-17.725378875017583, -63.16942190429985),
];

const List<LatLng> coordinates15 = [
  LatLng(-17.74956146485105, -63.157393548227404),
  LatLng(-17.74889692130285, -63.15640001616633),
  LatLng(-17.753479212285914, -63.155506487062084),
  LatLng(-17.75055341192085, -63.15366907213514),
  LatLng(-17.748048988342376, -63.15510886053068),
  LatLng(-17.74672427566964, -63.158238312345674),
  LatLng(-17.745352289334456, -63.15376769586025),
  LatLng(-17.745542098956143, -63.149792474515806),
];

const List<LatLng> coordinates16 = [
  LatLng(-17.731488544913777, -63.124025390252335),
  LatLng(-17.73334818712934, -63.12349587691251),
  LatLng(-17.732896214665843, -63.11929503908362),
  LatLng(-17.73222030202595, -63.11805336593966),
  LatLng(-17.73030534744554, -63.11698910427501),
  LatLng(-17.729685519377096, -63.11639729839961),
  LatLng(-17.728334654623666, -63.123788932555904),
];

const List<LatLng> coordinates17 = [
  LatLng(-17.76333671380912, -63.11821865812113),
  LatLng(-17.76570542975779, -63.11455464780266),
  LatLng(-17.76086130009924, -63.113134767012305),
  LatLng(-17.761875234413033, -63.10449970877161),
  LatLng(-17.76671938190533, -63.10863997098896),
  LatLng(-17.767845949599096, -63.1117156964113),
];

const List<LatLng> coordinates18 = [
  LatLng(-17.736641280702496, -63.11455290785747),
  LatLng(-17.74002061889267, -63.11762827950173),
  LatLng(-17.7437378879951, -63.12058551993237),
  LatLng(-17.74576610388533, -63.11680013138896),
  LatLng(-17.741372604129072, -63.11561762328087),
  LatLng(-17.739006968820963, -63.11478956788963),
  LatLng(-17.743738573254433, -63.110413495449976),
];

const List<LatLng> coordinates19 = [
  LatLng(-17.734016597504873, -63.0858710534641),
  LatLng(-17.738864402650727, -63.08397698552692),
  LatLng(-17.74427565331825, -63.085043003868144),
  LatLng(-17.742584781367416, -63.084687777548986),
  LatLng(-17.737736374011416, -63.075335773853375),
  LatLng(-17.72781483731854, -63.076046709444576),
  LatLng(-17.730634058819046, -63.08113651868389),
];

const List<LatLng> coordinates20 = [
  LatLng(-17.80652373656681, -63.14296666661261),
  LatLng(-17.810023861349784, -63.14480539909272),
  LatLng(-17.812888094967757, -63.142131850919945),
  LatLng(-17.80970635134815, -63.13828777995744),
  LatLng(-17.80604660625331, -63.141295468009844),
  LatLng(-17.806524275281557, -63.137786131050596),
  LatLng(-17.810979612875474, -63.13294014848388),
];

const List<LatLng> coordinates21 = [
  LatLng(-17.79486572509411, -63.11175768357541),
  LatLng(-17.802178372125766, -63.118610255122036),
  LatLng(-17.80690305031431, -63.113765995874296),
  LatLng(-17.800372976965736, -63.10218276992376),
  LatLng(-17.796535371545318, -63.10040002691656),
  LatLng(-17.793738153637253, -63.10821220120139),
];

const List<LatLng> coordinates22 = [
  LatLng(-17.824345581961403, -63.10288724592162),
  LatLng(-17.827721372691666, -63.10490026983452),
  LatLng(-17.827159014619422, -63.09507482370094),
  LatLng(-17.823781063342622, -63.09270983574983),
  LatLng(-17.820967093378886, -63.09826906482985),
  LatLng(-17.81533695069049, -63.093538730102914),
];

const List<LatLng> coordinates23 = [
  LatLng(-17.85712992959987, -63.150001877275294),
  LatLng(-17.861278787024027, -63.15661017270094),
  LatLng(-17.863420263516634, -63.15569645525514),
  LatLng(-17.860877865680507, -63.15316626310008),
  LatLng(-17.864089540677778, -63.15246230056335),
  LatLng(-17.862952703536237, -63.15028324848309),
  LatLng(-17.861480304430252, -63.14669701627318),
  LatLng(-17.8581338676986, -63.149158095126126),
  LatLng(-17.854386630689316, -63.15035276415045),
];

const List<LatLng> coordinates24 = [
  LatLng(-17.736641280702496, -63.11455290785747),
  LatLng(-17.74002061889267, -63.11762827950173),
  LatLng(-17.7437378879951, -63.12058551993237),
  LatLng(-17.74576610388533, -63.11680013138896),
  LatLng(-17.741372604129072, -63.11561762328087),
  LatLng(-17.739006968820963, -63.11478956788963),
  LatLng(-17.743738573254433, -63.110413495449976),
];

const List<LatLng> coordinates25 = [
  LatLng(-17.734016597504873, -63.0858710534641),
  LatLng(-17.738864402650727, -63.08397698552692),
  LatLng(-17.74427565331825, -63.085043003868144),
  LatLng(-17.742584781367416, -63.084687777548986),
  LatLng(-17.737736374011416, -63.075335773853375),
  LatLng(-17.72781483731854, -63.076046709444576),
  LatLng(-17.730634058819046, -63.08113651868389),
];

const List<LatLng> coordinates26 = [
  LatLng(-17.80652373656681, -63.14296666661261),
  LatLng(-17.810023861349784, -63.14480539909272),
  LatLng(-17.812888094967757, -63.142131850919945),
  LatLng(-17.80970635134815, -63.13828777995744),
  LatLng(-17.80604660625331, -63.141295468009844),
  LatLng(-17.806524275281557, -63.137786131050596),
  LatLng(-17.810979612875474, -63.13294014848388),
];

const List<LatLng> coordinates27 = [
  LatLng(-17.79486572509411, -63.11175768357541),
  LatLng(-17.802178372125766, -63.118610255122036),
  LatLng(-17.80690305031431, -63.113765995874296),
  LatLng(-17.800372976965736, -63.10218276992376),
  LatLng(-17.796535371545318, -63.10040002691656),
  LatLng(-17.793738153637253, -63.10821220120139),
];

const List<LatLng> coordinates28 = [
  LatLng(-17.824345581961403, -63.10288724592162),
  LatLng(-17.827721372691666, -63.10490026983452),
  LatLng(-17.827159014619422, -63.09507482370094),
  LatLng(-17.823781063342622, -63.09270983574983),
  LatLng(-17.820967093378886, -63.09826906482985),
  LatLng(-17.81533695069049, -63.093538730102914),
];

const List<LatLng> coordinates29 = [
  LatLng(-17.85712992959987, -63.150001877275294),
  LatLng(-17.861278787024027, -63.15661017270094),
  LatLng(-17.863420263516634, -63.15569645525514),
  LatLng(-17.860877865680507, -63.15316626310008),
  LatLng(-17.864089540677778, -63.15246230056335),
  LatLng(-17.862952703536237, -63.15028324848309),
  LatLng(-17.861480304430252, -63.14669701627318),
  LatLng(-17.8581338676986, -63.149158095126126),
  LatLng(-17.854386630689316, -63.15035276415045),
];

const List<LatLng> coordinates30 = [
  LatLng(-17.82292880381858, -63.22887769069588),
  LatLng(-17.824030751888124, -63.225910187301444),
  LatLng(-17.825753807600663, -63.22533126860578),
  LatLng(-17.82678733837608, -63.22699593463168),
  LatLng(-17.830852547775333, -63.22467983171958),
  LatLng(-17.828441631798864, -63.22047996782716),
  LatLng(-17.82651170089751, -63.21758096425531),
];

const List<LatLng> coordinates31 = [
  LatLng(-17.794974631822452, -63.18822117511426),
  LatLng(-17.795846985764324, -63.186877430949956),
  LatLng(-17.794218864215143, -63.18584274499741),
  LatLng(-17.792938644438145, -63.185868770156965),
  LatLng(-17.79357853412189, -63.18996212309286),
  LatLng(-17.793433209191974, -63.19136718875279),
  LatLng(-17.791570578842975, -63.190084435648636),
  LatLng(-17.789651394551036, -63.18843462849075),
  LatLng(-17.78994688570833, -63.186024816832436),
  LatLng(-17.79166258905349, -63.18392125390097),
];

const List<LatLng> coordinates32 = [
  LatLng(-17.77939392488842, -63.18047362018749),
  LatLng(-17.780274633976397, -63.17775099959048),
  LatLng(-17.77936960294857, -63.17692859368644),
  LatLng(-17.7801767854675, -63.175000886013976),
  LatLng(-17.77863424452192, -63.17296599863491),
  LatLng(-17.777776988796468, -63.17322228009899),
  LatLng(-17.777558010292644, -63.175179184394565),
  LatLng(-17.77689963556302, -63.178804001173525),
  LatLng(-17.776336440651153, -63.176671758280186),
  LatLng(-17.77592021644117, -63.175720966023555),
  LatLng(-17.77746064272451, -63.17438357237242),
];

const List<LatLng> coordinates33 = [
  LatLng(-17.832309053427664, -63.197091788288574),
  LatLng(-17.834302536951675, -63.19619436812822),
  LatLng(-17.833305839080147, -63.19357675047242),
  LatLng(-17.828820465592166, -63.19754043013024),
  LatLng(-17.829318883768234, -63.19537161674017),
  LatLng(-17.835584065571837, -63.19507255156702),
];

const List<LatLng> coordinates34 = [
  LatLng(-17.852811876247184, -63.2026487601402),
  LatLng(-17.85765257477146, -63.20608954515099),
  LatLng(-17.86050036266986, -63.20220043891049),
  LatLng(-17.860358103294722, -63.198385923396394),
  LatLng(-17.856513916933963, -63.195992448156204),
  LatLng(-17.854947746400857, -63.19659075170933),
  LatLng(-17.85238491424511, -63.19786213496386),
  LatLng(-17.855659667027957, -63.19285118586897),
];

const List<LatLng> coordinates35 = [
  LatLng(-17.793155740551022, -63.17371512666917),
  LatLng(-17.794615622638386, -63.17072354143157),
  LatLng(-17.794063700163225, -63.16662878382994),
  LatLng(-17.79128645445829, -63.16935863307681),
  LatLng(-17.79103720692838, -63.171434023252004),
  LatLng(-17.796200074284577, -63.173060767510236),
  LatLng(-17.7963247006553, -63.167470139018796),
];

const List<LatLng> coordinates36 = [
  LatLng(-17.84660250991635, -63.16937199822756),
  LatLng(-17.848253127732075, -63.164168856989725),
  LatLng(-17.853121228527378, -63.166925809695066),
  LatLng(-17.848549721435244, -63.17052816247724),
  LatLng(-17.846602343421647, -63.16572543468692),
  LatLng(-17.849142265579033, -63.16830461400271),
  LatLng(-17.850200345201568, -63.16470239160552),
];

// Coordenadas de la zona 2 (Área Residencial)
const List<LatLng> coordinates37 = [
  LatLng(-17.83843799418403, -63.21477117626536),
  LatLng(-17.84326507354392, -63.22114019098753),
  LatLng(-17.843153065597463, -63.2167764194378),
  LatLng(-17.838999138912474, -63.21830928276835),
  LatLng(-17.84405126430976, -63.215361213106185),
  LatLng(-17.839223797406397, -63.21595057966536),
  LatLng(-17.83911173465662, -63.21028968009701),
  LatLng(-17.83675414595792, -63.21123307216629),
];

// Coordenadas de la zona 3 (Área Central)
const List<LatLng> coordinates38 = [
  LatLng(-17.838418006268896, -63.174363587626154),
  LatLng(-17.839552820442105, -63.17576597547187),
  LatLng(-17.837817125503793, -63.1718392245775),
  LatLng(-17.839419255194414, -63.17415316587228),
  LatLng(-17.83861802430324, -63.17001597484937),
  LatLng(-17.84275663836856, -63.17092725573425),
  LatLng(-17.84042027595703, -63.16966520948945),
  LatLng(-17.83941908161055, -63.17078726734819),
];

const List<LatLng> coordinates40 = [
  LatLng(-17.79853523204894, -63.204598339896044),
  LatLng(-17.79719880303625, -63.202364225898975),
  LatLng(-17.796544205148432, -63.201161236395365),
  LatLng(-17.79545324664888, -63.20007284596422),
  LatLng(-17.797608113241967, -63.209238523523375),
  LatLng(-17.795917260034095, -63.20923855203607),
  LatLng(-17.793462755672753, -63.20780648492195),
  LatLng(-17.792944429446027, -63.20385385825236),
  LatLng(-17.793571498444567, -63.20067446801794),
  LatLng(-17.79586261504305, -63.205515023475314),
];

List<List<LatLng>> zonasPuntos = [
  coordinates1, // Zona Equipetrol Norte
  coordinates2, // Zona Equipetrol Sur
  coordinates3, // Zona Sirari
  coordinates4, // Zona Villa 1ro de Mayo
  coordinates5, // Zona Plan 3000
  coordinates6, // Zona Los Lotes
  coordinates7, // Zona Villa San Jorge
  coordinates8, // Zona Pampa de la Isla
  coordinates9, // Zona Los Chacos
  coordinates10, // Zona Urbanización del Norte
  coordinates11, // Zona El Remanso
  coordinates12, // Zona Las Palmeras
  coordinates13, // Zona El Bajío
  coordinates14, // Zona Santa Cruz de la Sierra Centro
  coordinates15, // Zona El Carmen
  coordinates16, // Zona La Cuchilla
  coordinates17, // Zona Las Misiones
  coordinates18, // Zona San Roque
  coordinates19, // Zona Villa Fátima
  coordinates20, // Zona El Quior
  coordinates21, // Zona Hamacas
  coordinates22, // Zona Santos Dumont
  coordinates23, // Zona Guapay
  coordinates24, // Zona Las Palmas
  coordinates25, // Zona Cristo Rey
  coordinates26, // Zona Los Mangales
  coordinates27, // Zona El Trompillo
  coordinates28, // Zona Urbarí
  coordinates29, // Zona Equipetrol Central
  coordinates30, // Zona Equipetrol Central
  coordinates31, // Zona Equipetrol Central
  coordinates32, // Zona Equipetrol Central
  coordinates33, // Zona Equipetrol Central
  coordinates34, // Zona Equipetrol Central
  coordinates35, // Zona Equipetrol Central
  coordinates36, // Zona Equipetrol Central
  coordinates37, // Zona Equipetrol Central
  coordinates38, // Zona Equipetrol Central
  coordinates40, // Zona Equipetrol Central
];

final Map<ReportMainCategory, String> mainCategories = {
  ReportMainCategory.delitos: 'Delitos y crímenes',
  ReportMainCategory.ordenPublico: 'Problemas de orden público',
  ReportMainCategory.emergencias: 'Emergencias y urgencias',
  ReportMainCategory.reporteComunitario: 'Reportes de la comunidad',
  ReportMainCategory.accidentes: 'Accidentes varios',
  ReportMainCategory.otros: 'Otros tipos de reportes',
};

final Map<ReportMainCategory, Map<ReportSubcategory, String>> subCategories = {
  ReportMainCategory.delitos: {
    ReportSubcategory.robo: 'Robo',
    ReportSubcategory.hurto: 'Hurto',
    ReportSubcategory.asalto: 'Asalto',
    ReportSubcategory.violenciaFamiliar: 'Violencia familiar',
    ReportSubcategory.extorsion: 'Extorsión',
    ReportSubcategory.secuestro: 'Secuestro',
    ReportSubcategory.homicidio: 'Homicidio',
    ReportSubcategory.violacionSexual: 'Violación sexual',
    ReportSubcategory.acoso: 'Acoso',
    ReportSubcategory.estafa: 'Estafa',
    ReportSubcategory.fraudeBancario: 'Fraude bancario',
    ReportSubcategory.violenciaGenero: 'Violencia de género',
    ReportSubcategory.maltratoInfantil: 'Maltrato infantil',
    ReportSubcategory.amenazas: 'Amenazas',
    ReportSubcategory.suicidio: 'Intento de suicidio',
  },
  ReportMainCategory.ordenPublico: {
    ReportSubcategory.vandalismo: 'Vandalismo',
    ReportSubcategory.disturbioPublico: 'Disturbios en vía pública',
    ReportSubcategory.establecimientoIrregular: 'Locales irregulares',
    ReportSubcategory.alcoholismo: 'Consumo de alcohol en vía pública',
    ReportSubcategory.drogadiccion: 'Drogas en vía pública',
    ReportSubcategory.prostitucion: 'Prostitución',
    ReportSubcategory.pandillaje: 'Pandillaje',
    ReportSubcategory.invasionPropiedad: 'Invasión de propiedad',
    ReportSubcategory.ventaIlegal: 'Venta ilegal de productos',
    ReportSubcategory.alteracionOrden: 'Alteración del orden público',
    ReportSubcategory.manifestacionIlegal: 'Manifestación no autorizada',
  },
  ReportMainCategory.emergencias: {
    ReportSubcategory.incendio: 'Incendios',
    ReportSubcategory.emergenciaMedica: 'Emergencias médicas',
    ReportSubcategory.desastreNatural: 'Desastres naturales',
    ReportSubcategory.personaExtraviada: 'Persona extraviada',
    ReportSubcategory.fugaGas: 'Fuga de gas',
    ReportSubcategory.colapsoEstructura: 'Colapso de estructura',
    ReportSubcategory.inundacion: 'Inundación',
    ReportSubcategory.explosionIncidente: 'Explosión/incidente con explosivos',
    ReportSubcategory.rescatePersona: 'Rescate de persona',
    ReportSubcategory.materialPeligroso: 'Incidente con material peligroso',
  },
  ReportMainCategory.accidentes: {
    ReportSubcategory.accidenteConstruccion: 'Accidente en construcción',
    ReportSubcategory.accidenteLaboral: 'Accidente laboral',
    ReportSubcategory.accidenteElectrico: 'Accidente eléctrico',
    ReportSubcategory.caidaAltura: 'Caída de altura',
    ReportSubcategory.quemaduras: 'Accidente con quemaduras',
    ReportSubcategory.intoxicacion: 'Intoxicación',
    ReportSubcategory.ahogamiento: 'Ahogamiento',
    ReportSubcategory.accidenteDeportivo: 'Accidente deportivo',
  },
  ReportMainCategory.reporteComunitario: {
    ReportSubcategory.ruidoMolesto: 'Ruidos molestos',
    ReportSubcategory.comercioInformal: 'Comercio informal',
    ReportSubcategory.basuraAcumulada: 'Acumulación de basura',
    ReportSubcategory.indigencia: 'Personas en situación de calle',
    ReportSubcategory.grafitis: 'Grafitis/pintas',
    ReportSubcategory.peleasCallejeras: 'Peleas en la vía pública',
    ReportSubcategory.abandonoAnimales: 'Abandono de animales',
    ReportSubcategory.maltratoAnimal: 'Maltrato animal',
    ReportSubcategory.contaminacionAmbiental: 'Contaminación ambiental',
    ReportSubcategory.obstruccionVia: 'Obstrucción de vía pública',
    ReportSubcategory.danosPropiedad: 'Daños a la propiedad pública',
    ReportSubcategory.actividadSospechosa: 'Actividad sospechosa',
  },
  ReportMainCategory.otros: {
    ReportSubcategory.otros: 'Otros tipos no categorizados',
  },
};
