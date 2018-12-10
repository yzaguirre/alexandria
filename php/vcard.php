https://github.com/jeroendesloovere/vcard/blob/master/examples/example_parsing.php

use JeroenDesloovere\VCard\VCardParser;
$parser = VCardParser::parseFromFile('contacts.vcf');
$vcards = $parser->getCards();
$vcard = $vcards[43];
$vcard = $vcards[66];
$phone1 = array_pop($vcard->phone);
$phone2 = array_pop($vcard->phone);
