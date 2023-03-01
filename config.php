<?php  // Moodle configuration file

unset($CFG);
global $CFG;
$CFG = new stdClass();

$CFG->dbtype    = '${DB_TYPE}';
$CFG->dblibrary = 'native';
$CFG->dbhost    = '${DB_HOST}';
$CFG->dbname    = '${DB_NAME}';
$CFG->dbuser    = '${DB_USERNAME}';
$CFG->dbpass    = '${DB_PASSWORD}';
$CFG->prefix    = '${DB_PREFIX}';
$CFG->dboptions = array (
  'dbpersist' => 0,
  'dbport' => ${DB_PORT},
  'dbsocket' => '',
);

$CFG->wwwroot   = '${WWWROOT}';
$CFG->dataroot  = '/var/lib/moodledata';
$CFG->admin     = 'admin';

$CFG->sslproxy = ${SSLPROXY};

$CFG->directorypermissions = 02777;

$CFG->xsendfile = 'X-Accel-Redirect';
$CFg->xsendfilealiases = array(
  '/dataroot/' => $CFG->dataroot,
  '/cachedir/' =>  $CFG->dataroot . '/cache',    // for custom $CFG->cachedir locations
  '/localcachedir/' => $CFG->dataroot . '/cache',    // for custom $CFG->localcachedir locations
  '/tempdir/'  => $CFG->dataroot . '/temp',     // for custom $CFG->tempdir locations
);

require_once(__DIR__ . '/lib/setup.php');

// There is no php closing tag in this file,
// it is intentional because it prevents trailing whitespace problems!

