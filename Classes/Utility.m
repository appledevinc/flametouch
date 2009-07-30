//
//  Constants.m
//  FlameTouch
//
//  Created by Tom Insam on 26/06/2009.
//  Copyright 2009 jerakeen.org. All rights reserved.
//

#import "Utility.h"

#include <netinet/in.h>
#include <arpa/inet.h>


@implementation Utility

@synthesize serviceNames;

static Utility* sharedConstantsInstance = nil;
+(Utility*)sharedInstance {
  if (!sharedConstantsInstance) {
    sharedConstantsInstance = [[Utility alloc] init];
  }
  return sharedConstantsInstance;
}

-(id)init {
  self = [super init];
  
  // this list autp-generated from http://www.dns-sd.org/ServiceTypes.html
  // using the ruby script 'service_list_builder.rb' and then edited by hand to
  // remove most of the awfulness
  self.serviceNames = [NSDictionary dictionaryWithObjectsAndKeys:
                       @"1Password Password Manager", @"_1password._tcp.",
                       @"Applied Biosystems Universal Instrument", @"_abi-instrument._tcp.",
                       @"FTK2 Database", @"_accessdata-f2d._tcp.",
                       @"FTK2 Backend Processing Agent", @"_accessdata-f2w._tcp.",
                       @"Strix Systems 5S/AccessOne", @"_accessone._tcp.",
                       @"MYOB AccountEdge", @"_accountedge._tcp.",
                       @"Adobe Acrobat", @"_acrobatsrv._tcp.",
                       @"ActionItems", @"_actionitems._tcp.",
                       @"Active Storage Proprietary Device", @"_activeraid._tcp.",
                       @"Active Storage Proprietary Device (Encrypted)", @"_activeraid-ssl._tcp.",
                       @"Address-O-Matic", @"_addressbook._tcp.",
                       @"Adobe Version Cue", @"_adobe-vc._tcp.",
                       @"Automatic Disk Discovery", @"_adisk._tcp.",
                       @"ADPRO Security Device Setup", @"_adpro-setup._tcp.",
                       @"Apple Application Engineering Services", @"_aecoretech._tcp.",
                       @"Aeroflex instrumentation and software", @"_aeroflex._tcp.",
                       @"Apple File Sharing", @"_afpovertcp._tcp.",
                       @"AirPort Base Station", @"_airport._tcp.",
                       @"AirProjector", @"_airprojector._tcp.",
                       @"Animo License Manager", @"_animolmd._tcp.",
                       @"Animo Batch", @"_animobserver._tcp.",
                       @"Appelezvous", @"_appelezvous._tcp.",
                       @"Apple Audio Units", @"_apple-ausend._tcp.",
                       @"Apple MIDI", @"_apple-midi._tcp.",
                       @"Apple Password Server", @"_apple-sasl._tcp.",
                       @"Apple Remote Debug Services", @"_applerdbg._tcp.",
                       @"Apple TV", @"_appletv._tcp.",
                       @"Apple TV iTunes discovery", @"_appletv-itunes._tcp.",
                       @"Apple TV Pairing", @"_appletv-pair._tcp.",
                       @"AquaMon", @"_aquamon._tcp.",
                       @"Apple Software Restore", @"_asr._tcp.",
                       @"Asterisk Caller-ID Notification", @"_astnotify._tcp.",
                       @"Astralite", @"_astralite._tcp.",
                       @"address-o-sync", @"_async._tcp.",
                       @"Allen Vanguard Hardware", @"_av._tcp.",
                       @"Axis Video Cameras", @"_axis-video._tcp.",
                       @"Authentication", @"_auth._tcp.",
                       @"3M Unitek Digital Orthodontic System", @"_b3d-convince._tcp.",
                       @"BibDesk Sharing", @"_bdsk._tcp.",
                       @"BeatPack Synchronization", @"_beatpack._tcp.",
                       @"Xgrid Technology Preview", @"_beep._tcp.",
                       @"BuildForge Agent", @"_bfagent._tcp.",
                       @"Big Bang Chess", @"_bigbangchess._tcp.",
                       @"Big Bang Mancala", @"_bigbangmancala._tcp.",
                       @"BitTorrent Peer", @"_bittorrent._tcp.",
                       @"Little Black Book", @"_blackbook._tcp.",
                       @"BlueVertise", @"_bluevertise._tcp.",
                       @"Bookworm", @"_bookworm._tcp.",
                       @"Bootstrap", @"_bootps._tcp.",
                       @"Proprietary", @"_boundaryscan._tcp.",
                       @"Bag Of Unusual Strategy Games", @"_bousg._tcp.",
                       @"RFID Reader Basic Reader Interface", @"_bri._tcp.",
                       @"Backup Simplicity", @"_bsqdea._tcp.",
                       @"BusySync Calendar Synchronization", @"_busycal._tcp.",
                       @"CalTalk", @"_caltalk._tcp.",
                       @"Card Send", @"_cardsend._tcp.",
                       @"The Cheat", @"_cheat._tcp.",
                       @"Project Gridlock", @"_chess._tcp.",
                       @"Fluid Theme", @"_chfts._tcp.",
                       @"The CHILI Radiology System", @"_chili._tcp.",
                       @"Clipboard Sharing", @"_clipboard._tcp.",
                       @"Clique Link-Local Multicast Chat Room", @"_clique._tcp.",
                       @"Oracle CLS Cluster Topology", @"_clscts._tcp.",
                       @"Published Collection Object", @"_collection._tcp.",
                       @"Now Contact", @"_contactserver._tcp.",
                       @"Corroboree", @"_corroboree._tcp.",
                       @"NoteBook 2", @"_cpnotebook2._tcp.",
                       @"CVS PServer", @"_cvspserver._tcp.",
                       @"CodeWarrior HTI Xscale PowerTAP", @"_cw-codetap._tcp.",
                       @"CodeWarrior HTI DPI PowerTAP", @"_cw-dpitap._tcp.",
                       @"CodeWarrior HTI OnCE PowerTAP", @"_cw-oncetap._tcp.",
                       @"CodeWarrior HTI COP PowerTAP", @"_cw-powertap._tcp.",
                       @"CyTV", @"_cytv._tcp.",
                       @"iTunes music sharing", @"_daap._tcp.",
                       @"iTunes control", @"_dacp._tcp.",
                       @"Device Info", @"_device-info._tcp.",
                       @"EyeHome", @"_difi._tcp.",
                       @"Distributed Compiler", @"_distcc._tcp.",
                       @"Ditrios SOA Framework", @"_ditrios._tcp.",
                       @"Dive Log Data Sharing and Synchronization", @"_divelogsync._tcp.",
                       @"Local Area Dynamic Time Synchronisation", @"_dltimesync._tcp.",
                       @"DNS Long-Lived Queries", @"_dns-llq._tcp.",
                       @"DNS Service Discovery", @"_dns-sd._tcp.",
                       @"DNS Dynamic Update", @"_dns-update._tcp.",
                       @"Domain Name Server", @"_domain._tcp.",
                       @"Vortimac Dossier", @"_dossier._tcp.",
                       @"iPhoto photo sharing", @"_dpap._tcp.",
                       @"DropCopy", @"_dropcopy._tcp.",
                       @"Data Synchronization Protocol", @"_dsl-sync._tcp.",
                       @"Desktop Transporter Remote Desktop", @"_dtrmtdesktop._tcp.",
                       @"DVB Service Discovery", @"_dvbservdsc._tcp.",
                       @"Earphoria", @"_earphoria._tcp.",
                       @"ebXML Messaging", @"_ebms._tcp.",
                       @"Northrup Grumman/Mission Systems/ESL Data Flow", @"_ecms._tcp.",
                       @"ebXML Registry", @"_ebreg._tcp.",
                       @"Net Monitor Anti-Piracy", @"_ecbyesfsgksc._tcp.",
                       @"LaCie Ethernet Disk Configuration", @"_edcp._tcp.",
                       @"Interactive Room Software Infrastructure (Event Sharing)", @"_eheap._tcp.",
                       @"DataEnvoy", @"_embrace._tcp.",
                       @"Remote AppleEvents", @"_eppc._tcp.",
                       @"Extensis Server", @"_esp._tcp.",
                       @"Now Up-to-Date", @"_eventserver._tcp.",
                       @"eWallet synchonization", @"_ewalletsync._tcp.",
                       @"Example Service Type", @"_example._tcp.",
                       @"Exbiblio Cascading", @"_exb._tcp.",
                       @"Remote Process Execution", @"_exec._tcp.",
                       @"Extensis Serial Number", @"_extensissn._tcp.",
                       @"EyeTV Sharing", @"_eyetvsn._tcp.",
                       @"FaceSpan", @"_facespan._tcp.",
                       @"Fairview Device Identification", @"_fairview._tcp.",
                       @"FAXstf", @"_faxstfx._tcp.",
                       @"NetNewsWire 2.0", @"_feed-sharing._tcp.",
                       @"Fish", @"_fish._tcp.",
                       @"Financial Information Exchange (FIX)", @"_fix._tcp.",
                       @"Fjork", @"_fjork._tcp.",
                       @"FilmLight Cluster Power Control", @"_fl-purr._tcp.",
                       @"FileMaker Pro", @"_fmpro-internal._tcp.",
                       @"FileMaker Server Administration", @"_fmserver-admin._tcp.",
                       @"FontAgent Pro", @"_fontagentnode._tcp.",
                       @"FoxTrot Professional Search", @"_foxtrot-start._tcp.",
                       @"FreeHand MusicPad Pro", @"_freehand._tcp.",
                       @"FTP", @"_ftp._tcp.",
                       @"Crocodile FTP", @"_ftpcroco._tcp.",
                       @"Fairview Certificate", @"_fv-cert._tcp.",
                       @"Fairview Key", @"_fv-key._tcp.",
                       @"Fairview Time/Date", @"_fv-time._tcp.",
                       @"Frog Navigation Systems", @"_frog._tcp.",
                       @"SnapMail", @"_gbs-smp._tcp.",
                       @"SnapTalk", @"_gbs-stp._tcp.",
                       @"G-Force Control", @"_gforce-ssmp._tcp.",
                       @"GlassPad Data Exchange", @"_glasspad._tcp.",
                       @"GlassPadServer Data Exchange", @"_glasspadserver._tcp.",
                       @"OpenGL Driver Monitor", @"_glrdrvmon._tcp.",
                       @"Grid Plug and Play", @"_gpnp._tcp.",
                       @"Roxio ToastAnywhere Recorder Sharing", @"_grillezvous._tcp.",
                       @"Growl", @"_growl._tcp.",
                       @"GUID resolving service", @"_guid._tcp.",
                       @"H.323", @"_h323._tcp.",
                       @"Helix Server", @"_helix._tcp.",
                       @"Home Media Control", @"_hmcp._tcp.",
                       @"HTTP server", @"_http._tcp.",
                       @"HTTPS server", @"_https._tcp.",
                       @"iDo Technology Home Automation", @"_homeauto._tcp.",
                       @"Honeywell Video Systems", @"_honeywell-vid._tcp.",
                       @"Hotwayd", @"_hotwayd._tcp.",
                       @"Howdy messaging and notification", @"_howdy._tcp.",
                       @"HP Remote Build (linux)", @"_hpr-bldlnx._tcp.",
                       @"HP Remote Build (Windows)", @"_hpr-bldwin._tcp.",
                       @"HP Remote Build database", @"_hpr-db._tcp.",
                       @"HP Remote Build (test results)", @"_hpr-rep._tcp.",
                       @"HP Remote Build (linux tools)", @"_hpr-toollnx._tcp.",
                       @"HP Remote Build (Windows tools)", @"_hpr-toolwin._tcp.",
                       @"HP Remote Test (linux)", @"_hpr-tstlnx._tcp.",
                       @"HP Remote Test (Windows)", @"_hpr-tstwin._tcp.",
                       @"Hobbyist Software Off Discovery", @"_hs-off._tcp.",
                       @"SubEthaEdit", @"_hydra._tcp.",
                       @"Inter Asterisk eXchange", @"_iax._tcp.",
                       @"iBiz Server", @"_ibiz._tcp.",
                       @"Image Capture Networking", @"_ica-networking._tcp.",
                       @"Northrup Grumman/TASC/ICAN", @"_ican._tcp.",
                       @"iChalk", @"_ichalkboard._tcp.",
                       @"iChat 1.0", @"_ichat._tcp.",
                       @"iConquer", @"_iconquer._tcp.",
                       @"Data Acquisition and Control", @"_idata._tcp.",
                       @"SplashID Synchronization", @"_idsync._tcp.",
                       @"Published iFolder", @"_ifolder._tcp.",
                       @"Idle Hands iHouse", @"_ihouse._tcp.",
                       @"Instant Interactive Drills", @"_ii-drills._tcp.",
                       @"Instant Interactive Konane", @"_ii-konane._tcp.",
                       @"iLynX", @"_ilynx._tcp.",
                       @"Internet Message Access", @"_imap._tcp.",
                       @"iMidi", @"_imidi._tcp.",
                       @"Inova Solutions OnTrack Display", @"_inova-ontrack._tcp.",
                       @"Intermec Device Configuration", @"_idcws._tcp.",
                       @"IP Broadcaster", @"_ipbroadcaster._tcp.",
                       @"Internet Printing Protocol", @"_ipp._tcp.",
                       @"IP Speaker Control", @"_ipspeaker._tcp.",
                       @"Intego Remote Management Console", @"_irmc._tcp.",
                       @"Internet Small Computer Systems Interface (iSCSI)", @"_iscsi._tcp.",
                       @"iSparx", @"_isparx._tcp.",
                       @"iSpQ VideoChat", @"_ispq-vc._tcp.",
                       @"iShare", @"_ishare._tcp.",
                       @"iSticky", @"_isticky._tcp.",
                       @"iStorm", @"_istorm._tcp.",
                       @"iTunes Socket Remote Control", @"_itsrc._tcp.",
                       @"iWork Server", @"_iwork._tcp.",
                       @"Northrup Grumman/TASC/JCAN", @"_jcan._tcp.",
                       @"Jedit X", @"_jeditx._tcp.",
                       @"Jini Service Discovery", @"_jini._tcp.",
                       @"Kerberos", @"_kerberos._tcp.",
                       @"Kerberos Administration", @"_kerberos-adm._tcp.",
                       @"Kabira Transaction Platform", @"_ktp._tcp.",
                       @"Lan2P Peer-to-Peer Network", @"_lan2p._tcp.",
                       @"Gawker", @"_lapse._tcp.",
                       @"LANrev Agent", @"_lanrevagent._tcp.",
                       @"LANrev Server", @"_lanrevserver._tcp.",
                       @"LDAP Server", @"_ldap._tcp.",
                       @"Lexicon Vocabulary Sharing", @"_lexicon._tcp.",
                       @"Liaison", @"_liaison._tcp.",
                       @"Delicious Library 2", @"_delibrary2._tcp.",
                       @"Delicious Library 2", @"_library._tcp.",
                       @"RFID reader Low Level Reader", @"_llrp._tcp.",
                       @"RFID reader Low Level Reader (secure)", @"_llrp-secure._tcp.",
                       @"Gobby", @"_lobby._tcp.",
                       @"Logic Pro Distributed Audio", @"_logicnode._tcp.",
                       @"Remote Login", @"_login._tcp.",
                       @"LonTalk over IP (ANSI 852)", @"_lontalk._tcp.",
                       @"Echelon LNS Remote Client", @"_lonworks._tcp.",
                       @"Linksys One Application Server", @"_lsys-appserver._tcp.",
                       @"Linksys One Camera", @"_lsys-camera._tcp.",
                       @"LinkSys EZ Configuration", @"_lsys-ezcfg._tcp.",
                       @"LinkSys Operations, Administration, Management, and Provisioning", @"_lsys-oamp._tcp.",
                       @"Lux Solis Data Transport", @"_lux-dtp._tcp.",
                       @"LXI", @"_lxi._tcp.",
                       @"iPod Lyrics", @"_lyrics._tcp.",
                       @"MacFOH", @"_macfoh._tcp.",
                       @"MacFOH admin services", @"_macfoh-admin._tcp.",
                       @"MacFOH audio stream", @"_macfoh-audio._tcp.",
                       @"MacFOH show control events", @"_macfoh-events._tcp.",
                       @"MacFOH realtime data", @"_macfoh-data._tcp.",
                       @"MacFOH database", @"_macfoh-db._tcp.",
                       @"MacFOH Remote", @"_macfoh-remote._tcp.",
                       @"Mac Minder", @"_macminder._tcp.",
                       @"Maestro Music Sharing", @"_maestro._tcp.",
                       @"Magic Dice Game", @"_magicdice._tcp.",
                       @"Mandos Password Server", @"_mandos._tcp.",
                       @"MediaBroker++ Consumer", @"_mbconsumer._tcp.",
                       @"MediaBroker++ Producer", @"_mbproducer._tcp.",
                       @"MediaBroker++ Server", @"_mbserver._tcp.",
                       @"MediaCentral", @"_mcrcp._tcp.",
                       @"Mes Amis", @"_mesamis._tcp.",
                       @"Mimer SQL Engine", @"_mimer._tcp.",
                       @"Mental Ray for Maya", @"_mi-raysat._tcp.",
                       @"modo LAN Services", @"_modolansrv._tcp.",
                       @"SplashMoney Synchronization", @"_moneysync._tcp.",
                       @"MoneyWorks", @"_moneyworks._tcp.",
                       @"Mother script server", @"_mother._tcp.",
                       @"MP3 Sushi", @"_mp3sushi._tcp.",
                       @"IBM MQ Telemetry Transport Broker", @"_mqtt._tcp.",
                       @"Martian SlingShot", @"_mslingshot._tcp.",
                       @"MySync", @"_mysync._tcp.",
                       @"MenuTunes Sharing", @"_mttp._tcp.",
                       @"MatrixStore", @"_mxs._tcp.",
                       @"Network Clipboard Broadcasts", @"_ncbroadcast._tcp.",
                       @"Network Clipboard Direct Transfers", @"_ncdirect._tcp.",
                       @"Network Clipboard Sync Server", @"_ncsyncserver._tcp.",
                       @"NeoRiders Client", @"_neoriders._tcp.",
                       @"Apple Remote Desktop", @"_net-assistant._tcp.",
                       @"Vesa Net2Display", @"_net2display._tcp.",
                       @"NetRestore", @"_netrestore._tcp.",
                       @"Escale", @"_newton-dock._tcp.",
                       @"Network File System - Sun Microsystems", @"_nfs._tcp.",
                       @"DO over NSSocketPort", @"_nssocketport._tcp.",
                       @"American Dynamics Intellex Archive Management", @"_ntlx-arch._tcp.",
                       @"American Dynamics Intellex Enterprise Management", @"_ntlx-ent._tcp.",
                       @"American Dynamics Intellex Video", @"_ntlx-video._tcp.",
                       @"Network Time", @"_ntp._tcp.",
                       @"Tenasys", @"_ntx._tcp.",
                       @"Observations Framework", @"_obf._tcp.",
                       @"Objective", @"_objective._tcp.",
                       @"Oce Common Exchange", @"_oce._tcp.",
                       @"OD4Contact", @"_odabsharing._tcp.",
                       @"Optical Disk Sharing", @"_odisk._tcp.",
                       @"OmniFocus setting configuration", @"_ofocus-conf._tcp.",
                       @"OmniFocus document synchronization", @"_ofocus-sync._tcp.",
                       @"OLPC activity", @"_olpc-activity1._tcp.",
                       @"OmniWeb", @"_omni-bookmark._tcp.",
                       @"OpenBase SQL", @"_openbase._tcp.",
                       @"Conferencing", @"_opencu._tcp.",
                       @"oprofile server", @"_oprofile._tcp.",
                       @"Open Sound Control Interface Transfer", @"_oscit._tcp.",
                       @"ObjectVideo OV Ready", @"_ovready._tcp.",
                       @"OWFS web server", @"_owhttpd._tcp.",
                       @"OWFS server", @"_owserver._tcp.",
                       @"Remote Parental Controls", @"_parentcontrol._tcp.",
                       @"PasswordWallet Data Synchronization", @"_passwordwallet._tcp.",
                       @"Mac OS X Podcast Producer Server", @"_pcast._tcp.",
                       @"Peer-to-Peer Chat", @"_p2pchat._tcp.",
                       @"PhoneValet Anywhere", @"_parliant._tcp.",
                       @"Printer Page Description Language", @"_pdl-datastream._tcp.",
                       @"Horowitz Key Protocol", @"_pgpkey-hkp._tcp.",
                       @"PGP Keyserver (HTTP)", @"_pgpkey-https._tcp.",
                       @"PGP Keyserver (HTTPS)", @"_pgpkey-https._tcp.",
                       @"PGP Keyserver (LDAP)", @"_pgpkey-ldap._tcp.",
                       @"PGP Keyserver (SMTP)", @"_pgpkey-mailto._tcp.",
                       @"Photo Parata Event Photography Software", @"_photoparata._tcp.",
                       @"Pictua Intercommunication", @"_pictua._tcp.",
                       @"pieSync Computer to Computer Synchronization", @"_piesync._tcp.",
                       @"Pedestal Interface Unit by RPM-PSI", @"_piu._tcp.",
                       @"Parallel OperatiOn and Control Heuristic (Pooch)", @"_poch._tcp.",
                       @"'Poke Eye' Elgato EyeTV remote", @"_pokeeye._tcp.",
                       @"POP3 server", @"_pop3._tcp.",
                       @"PostgreSQL Server", @"_postgresql._tcp.",
                       @"PowerEasy ERP", @"_powereasy-erp._tcp.",
                       @"PowerEasy Point of Sale", @"_powereasy-pos._tcp.",
                       @"Piano Player Remote Control", @"_pplayer-ctrl._tcp.",
                       @"Link-Local Messaging / presence", @"_presence._tcp.",
                       @"Print capabilities", @"_print-caps._tcp.",
                       @"LPR/LPD printing", @"_printer._tcp.",
                       @"Profile for Mac medical practice management software", @"_profilemac._tcp.",
                       @"Prolog", @"_prolog._tcp.",
                       @"Physical Security Interoperability Alliance", @"_psia._tcp.",
                       @"PTNetPro", @"_ptnetprosrv2._tcp.",
                       @"Picture Transfer", @"_ptp._tcp.",
                       @"PTP Initiation Request", @"_ptp-req._tcp.",
                       @"QBox Appliance Locator", @"_qbox._tcp.",
                       @"QuickTime Transfer", @"_qttp._tcp.",
                       @"Quinn Game Server", @"_quinn._tcp.",
                       @"Rakket Client", @"_rakket._tcp.",
                       @"RadioTAG: Event tagging", @"_radiotag._tcp.",
                       @"RadioVIS: Visualisation", @"_radiovis._tcp.",
                       @"RadioEPG", @"_radioepg._tcp.",
                       @"Remote Audio Output Protocol (AirTunes)", @"_raop._tcp.",
                       @"RBR Instrument Communication", @"_rbr._tcp.",
                       @"PowerCard", @"_rce._tcp.",
                       @"Windows Remote Desktop", @"_rdp._tcp.",
                       @"RealPlayer Shared Favorites", @"_realplayfavs._tcp.",
                       @"Recipe Sharing", @"_recipe._tcp.",
                       @"LaCie Remote Burn", @"_remoteburn._tcp.",
                       @"ARTvps RenderDrive/PURE Renderer", @"_renderpipe._tcp.",
                       @"RendezvousPong", @"_rendezvouspong._tcp.",
                       @"Community", @"_resacommunity._tcp.",
                       @"RESOL VBus", @"_resol-vbus._tcp.",
                       @"Retrospect backup and restore", @"_retrospect._tcp.",
                       @"Remote Frame Buffer (VNC)", @"_rfb._tcp.",
                       @"Remote Frame Buffer (VNC) Client", @"_rfbc._tcp.",
                       @"RFID Reader Mach1", @"_rfid._tcp.",
                       @"Remote I/O USB Printer", @"_riousbprint._tcp.",
                       @"Roku Control", @"_roku-rcp._tcp.",
                       @"RemoteQuickLaunch", @"_rql._tcp.",
                       @"Remote System Management Protocol", @"_rsmp-server._tcp.",
                       @"Rsync", @"_rsync._tcp.",
                       @"Real Time Streaming", @"_rtsp._tcp.",
                       @"RubyGems GemServer", @"_rubygems._tcp.",
                       @"Safari Menu", @"_safarimenu._tcp.",
                       @"Salling Clicker Sharing", @"_sallingbridge._tcp.",
                       @"Salling Clicker", @"_sallingclicker._tcp.",
                       @"Salutafugi", @"_salutafugijms._tcp.",
                       @"Sandvox", @"_sandvox._tcp.",
                       @"Bonjour Scanning", @"_scanner._tcp.",
                       @"Schick", @"_schick._tcp.",
                       @"Scone", @"_scone._tcp.",
                       @"IEEE 488.2 (SCPI) Socket", @"_scpi-raw._tcp.",
                       @"IEEE 488.2 (SCPI) Telnet", @"_scpi-telnet._tcp.",
                       @"Speed Download", @"_sdsharing._tcp.",
                       @"SubEthaEdit 2", @"_see._tcp.",
                       @"seeCard", @"_seeCard._tcp.",
                       @"Senteo Assessment Software", @"_senteo-http._tcp.",
                       @"Sentillion Vault System", @"_sentillion-vlc._tcp.",
                       @"Sentillion Vault Systems Cluster", @"_sentillion-vlt._tcp.",
                       @"serendiPd Shared Patches for Pure Data", @"_serendipd._tcp.",
                       @"ServerEye AgentContainer Communication", @"_servereye._tcp.",
                       @"Mac OS X Server Admin", @"_servermgr._tcp.",
                       @"DNS Service Discovery", @"_services._tcp.",
                       @"Session File Sharing", @"_sessionfs._tcp.",
                       @"SFTP server", @"_sftp-ssh._tcp.",
                       @"Swift Office Ships", @"_shipsgm._tcp.",
                       @"Swift Office Ships", @"_shipsinvit._tcp.",
                       @"SplashShopper Synchronization", @"_shoppersync._tcp.",
                       @"Nicecast", @"_shoutcast._tcp.",
                       @"VoIP signalling (SIP)", @"_sip._tcp.",
                       @"VoIP signalling (SIP) URI", @"_sipuri._tcp.",
                       @"Sirona Xray", @"_sironaxray._tcp.",
                       @"Skype", @"_skype._tcp.",
                       @"Sleep Proxy Server", @"_sleep-proxy._tcp.",
                       @"SliMP3 Server Command-Line", @"_slimcli._tcp.",
                       @"SliMP3 Server Web Interface", @"_slimhttp._tcp.",
                       @"SMB server", @"_smb._tcp.",
                       @"Simple Object Access Protocol (SOAP)", @"_soap._tcp.",
                       @"Simple Object eXchange", @"_sox._tcp.",
                       @"sPearCat Host Discovery", @"_spearcat._tcp.",
                       @"Shared Clipboard", @"_spike._tcp.",
                       @"Spin Crisis", @"_spincrisis._tcp.",
                       @"launchTunes", @"_spl-itunes._tcp.",
                       @"netTunes", @"_spr-itunes._tcp.",
                       @"SplashData Synchronization", @"_splashsync._tcp.",
                       @"SSH remote login", @"_ssh._tcp.",
                       @"Screen Sharing", @"_ssscreenshare._tcp.",
                       @"Strateges", @"_strateges._tcp.",
                       @"Sun Grid Engine (Execution Host)", @"_sge-exec._tcp.",
                       @"Sun Grid Engine (Master)", @"_sge-qmaster._tcp.",
                       @"SousChef Recipe Sharing", @"_souschef._tcp.",
                       @"SPARQL", @"_sparql._tcp.",
                       @"Lexcycle Stanza", @"_stanza._tcp.",
                       @"Sticky Notes", @"_stickynotes._tcp.",
                       @"Message Submission", @"_submission._tcp.",
                       @"Supple", @"_supple._tcp.",
                       @"Surveillus Networks", @"_surveillus._tcp.",
                       @"Subversion", @"_svn._tcp.",
                       @"Signwave Card Sharing", @"_swcards._tcp.",
                       @"Wireless home control", @"_switcher._tcp.",
                       @"Swordfish", @"_swordfish._tcp.",
                       @"Synchronize! Pro X", @"_sxqdea._tcp.",
                       @"Sybase", @"_sybase-tds._tcp.",
                       @"Syncopation", @"_syncopation._tcp.",
                       @"Synchronize! X Plus 2.0", @"_syncqdea._tcp.",
                       @"Data Transmission and Synchronization", @"_taccounting._tcp.",
                       @"Tapinoma Easycontact", @"_tapinoma-ecs._tcp.",
                       @"Task Coach", @"_taskcoachsync._tcp.",
                       @"tbricks internal", @"_tbricks._tcp.",
                       @"Time Code", @"_tcode._tcp.",
                       @"Tracking Control Unit", @"_tcu._tcp.",
                       @"ARTIS Team Task", @"_teamlist._tcp.",
                       @"teleport", @"_teleport._tcp.",
                       @"Telnet", @"_telnet._tcp.",
                       @"Terascala Maintenance", @"_tera-mp._tcp.",
                       @"ThinkFlood RedEye IR bridge", @"_tf-redeye._tcp.",
                       @"tftp", @"_tftp._tcp.",
                       @"TI Connect Manager", @"_ticonnectmgr._tcp.",
                       @"Timbuktu", @"_timbuktu._tcp.",
                       @"TI Navigator Hub 1.0", @"_tinavigator._tcp.",
                       @"TiVo Home Media Engine", @"_tivo-hme._tcp.",
                       @"TiVo Music", @"_tivo-music._tcp.",
                       @"TiVo Photos", @"_tivo-photos._tcp.",
                       @"TiVo Remote", @"_tivo-remote._tcp.",
                       @"TiVo Videos", @"_tivo-videos._tcp.",
                       @"Tomboy", @"_tomboy._tcp.",
                       @"ToothPics Dental Office", @"_toothpicserver._tcp.",
                       @"iPhone/iPod Remote Control", @"_touch-able._tcp.",
                       @"iPhone/iPod Remote Pairing", @"_touch-remote._tcp.",
                       @"Tryst", @"_tryst._tcp.",
                       @"TechTool Pro 4 Anti-Piracy", @"_ttp4daemon._tcp.",
                       @"Tunage Media Control", @"_tunage._tcp.",
                       @"TuneRanger", @"_tuneranger._tcp.",
                       @"Ubertragen", @"_ubertragen._tcp.",
                       @"UDDI", @"_uddi._tcp.",
                       @"UDDI Inquiry", @"_uddi-inq._tcp.",
                       @"UDDI Publishing", @"_uddi-pub._tcp.",
                       @"UDDI Subscription", @"_uddi-sub._tcp.",
                       @"UDDI Security", @"_uddi-sec._tcp.",
                       @"Universal Plug and Play", @"_upnp._tcp.",
                       @"Universal Switching Corporation", @"_uswi._tcp.",
                       @"uTest", @"_utest._tcp.",
                       @"American Dynamics VideoEdge Decoder", @"_ve-decoder._tcp.",
                       @"American Dynamics VideoEdge Encoder", @"_ve-encoder._tcp.",
                       @"American Dynamics VideoEdge Recorder", @"_ve-recorder._tcp.",
                       @"visel Q-System services", @"_visel._tcp.",
                       @"Volley", @"_volley._tcp.",
                       @"Virtual Object System (using VOP/TCP)", @"_vos._tcp.",
                       @"VueProRenderCow", @"_vue4rendercow._tcp.",
                       @"VXI-11 Instrument", @"_vxi-11._tcp.",
                       @"WebDAV", @"_webdav._tcp.",
                       @"WebDAV over SSL/TLS", @"_webdavs._tcp.",
                       @"Whamb", @"_whamb._tcp.",
                       @"Wired Server", @"_wired._tcp.",
                       @"Workgroup Server Discovery", @"_wkgrpsvr._tcp.",
                       @"Workgroup Manager", @"_workstation._tcp.",
                       @"Wormhole", @"_wormhole._tcp.",
                       @"Workgroup", @"_workgroup._tcp.",
                       @"Web Services", @"_ws._tcp.",
                       @"Wyatt HELEOS", @"_wtc-heleos._tcp.",
                       @"Wyatt QELS", @"_wtc-qels._tcp.",
                       @"Wyatt Optilab rEX", @"_wtc-rex._tcp.",
                       @"Wyatt ViscoStar", @"_wtc-viscostar._tcp.",
                       @"Wyatt DynaPro Plate Reader", @"_wtc-wpr._tcp.",
                       @"x-plane 9", @"_x-plane9._tcp.",
                       @"Xcode Distributed Compiler", @"_xcodedistcc._tcp.",
                       @"xGate Remote Management Interface", @"_xgate-rmi._tcp.",
                       @"Xgrid", @"_xgrid._tcp.",
                       @"XMMS2 IPC", @"_xmms2._tcp.",
                       @"Xperientia Mobile", @"_xmp._tcp.",
                       @"XMPP Client", @"_xmpp-client._tcp.",
                       @"XMPP Server", @"_xmpp-server._tcp.",
                       @"Xsan Client", @"_xsanclient._tcp.",
                       @"Xsan Server", @"_xsanserver._tcp.",
                       @"Xsan System", @"_xsansystem._tcp.",
                       @"XServe RAID", @"_xserveraid._tcp.",
                       @"Xserve RAID Synchronization", @"_xsync._tcp.",
                       @"xTime License", @"_xtimelicence._tcp.",
                       @"xTime Project", @"_xtshapro._tcp.",
                       @"XUL over HTTP", @"_xul-http._tcp.",
                       @"Yakumo iPhone OS Device Control", @"_yakumo._tcp.",
                       @"Big Bang Backgammon", @"_bigbangbackgammon._tcp.",
                       @"Big Bang Checkers", @"_bigbangcheckers._tcp.",
                       @"ClipboardSharing", @"_clipboardsharing._tcp.",
                       @"InterBase Database Remote", @"_gds_db._tcp.",
                       @"Net Monitor Server", @"_netmonitorserver._tcp.",
                       @"OLPC Presence", @"_presence_olpc._tcp.",
                       @"Pop-Pop", @"_pop_2_ambrosia._tcp.",
                       @"ProfCast", @"_profCastLicense._tcp.",
                       @"World Book Encyclopedia", @"_WorldBook2004ST._tcp.",
                       nil
                       ];
  
  return self;
}

-(NSString*)nameForService:(NSNetService*)service {
  NSString *s = [self.serviceNames objectForKey:[service type]];
  if (s) return s;
  return [service type];
}


-(NSString*)hostnameForService:(NSNetService*)service {
  if ([service hostName])
    return [service hostName];
  struct sockaddr_in* sock = (struct sockaddr_in*)[((NSData*)[[service addresses] objectAtIndex:0]) bytes];
  return [NSString stringWithFormat:@"%s", inet_ntoa(sock->sin_addr)];
}

@end
