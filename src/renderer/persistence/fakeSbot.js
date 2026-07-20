import pull from 'pull-stream'
import crypto from 'crypto'

/**
 * Minimal in-memory fake of the sbot RPC surface used by SSBAdapter.
 *
 * Used when no real SSB backend is available (ssb_fake_data=1) so the
 * frontend can be developed/demoed without scuttlebot running. It ships
 * with a fictional data set for a left-autonomous social center: a handful
 * of collective members, a skill catalogue and a few ongoing project ideas.
 *
 * Type/action strings below mirror the constants in IdeaAdapter, SkillAdapter
 * and IdentityAdapter (not imported here to avoid a circular dependency with
 * SSBAdapter, which imports this module).
 */

const TALENET_PREFIX = 'talenet-'

const TYPE_ABOUT = 'about' // predefined by ssb, thus no prefix
const TYPE_IDEA_CREATE = TALENET_PREFIX + 'idea-create'
const TYPE_IDEA_UPDATE = TALENET_PREFIX + 'idea-update'
const TYPE_IDEA_SKILL_ASSIGNMENT = TALENET_PREFIX + 'idea-skill_assignment'
const TYPE_IDEA_HAT = TALENET_PREFIX + 'idea-hat'
const TYPE_IDEA_ASSOCIATION = TALENET_PREFIX + 'idea-association'
const TYPE_IDEA_COMMENT = TALENET_PREFIX + 'idea-comment'
const TYPE_IDEA_COMMENT_REPLY = TALENET_PREFIX + 'idea-comment_reply'
const TYPE_SKILL_CREATE = TALENET_PREFIX + 'skill-create'
const TYPE_SKILL_SIMILARITY = TALENET_PREFIX + 'skill-similarity'
const TYPE_IDENTITY_SKILL_ASSIGNMENT = TALENET_PREFIX + 'identity-skill_assignment'

const SKILLS_ARE_SIMILAR = 1

const ACTION_ASSIGN_SKILL = 'assign'
const ACTION_TAKE_HAT = 'take'
const ACTION_ASSOCIATE_WITH_IDEA = 'associate'

// Primarily tech/hacking skills, plus communication, social, activism and
// other skills you'd expect to find in a left-autonomous social center.
const SKILL_NAMES = [
  // Tech & Hacking
  'Linux-Administration',
  'Windows-Systemadministration',
  'Netzwerktechnik',
  'WLAN-Mesh-Netzwerke (Freifunk)',
  'Serverbetrieb / Selfhosting',
  'Docker & Container',
  'Datenbank-Administration',
  'IT-Sicherheit / Firewalls',
  'Penetration Testing',
  'Reverse Engineering',
  'Kryptographie (PGP/GPG)',
  'Tor & Onion-Services',
  'VPN-Einrichtung',
  'Sichere Kommunikation / OpSec',
  'Digitale Selbstverteidigung (Schulungen)',
  'Passwortmanager-Einrichtung',
  'Verschlüsselte Backups',
  'Python-Programmierung',
  'JavaScript-Programmierung',
  'Webentwicklung Frontend',
  'Webentwicklung Backend',
  'Mobile-App-Entwicklung',
  'Bash-Scripting / Automatisierung',
  'Git & Versionskontrolle',
  'Datenbank-Scraping / Recherchetools',
  'Nextcloud-Administration',
  'Mailserver-Administration',
  'CMS-Administration (WordPress etc.)',
  'Wiki-Pflege (MediaWiki)',
  'Barrierefreiheit im Web',
  'Übersetzungs-Tools / Lokalisierung',
  'Firmware-Flashing',
  'Hardware-Reparatur',
  'Löten',
  'Elektronik / Mikrocontroller (Arduino/Raspberry Pi)',
  '3D-Druck',
  'CAD / Technisches Zeichnen',
  'Amateurfunk',
  'Netzwerksicherheit / Monitoring',
  'Incident Response',
  'Malware-Analyse',
  'Social-Engineering-Awareness',
  'Datenschutzberatung (DSGVO)',
  'Open-Source-Lizenzierung',
  'Machine-Learning-Grundlagen',
  'Datenvisualisierung',
  'Grafikdesign (digital)',
  'Videoschnitt',
  'Audioproduktion / Podcast-Technik',
  'Streaming-Technik (Livestreams)',
  'Foto-Dokumentation',
  'Hardware-Recycling',
  'Repair-Café-Elektronik',
  'SDR (Software Defined Radio)',
  'Funkscanner-Technik',
  'Kabelverlegung / Netzwerkinstallation',
  'Betriebssystem-Härtung',
  'Sichere Datenträgerlöschung',
  'API-Entwicklung',
  'Datenbank-Design',

  // Kommunikation & Social
  'Pressearbeit',
  'Öffentlichkeitsarbeit',
  'Social-Media-Redaktion',
  'Layout & Satz (Print)',
  'Flyer- & Plakatgestaltung',
  'Übersetzen Englisch',
  'Übersetzen Arabisch',
  'Übersetzen Französisch',
  'Übersetzen Türkisch',
  'Moderation von Plena',
  'Konfliktmoderation',
  'Gewaltfreie Kommunikation',
  'Rhetorik & öffentliches Reden',
  'Newsletter-Redaktion',
  'Podcast-Produktion',
  'Freies Radio / Radiomoderation',
  'Community-Management',
  'Fotojournalismus',
  'Interviewführung',
  'Redaktion & Texten',
  'Lektorat & Korrektorat',
  'Mehrsprachige Moderation',
  'Awareness-Arbeit',
  'Deeskalationstraining',
  'Mediation / Vermittlung',
  'Kinderbetreuung bei Veranstaltungen',
  'Veranstaltungsmoderation',
  'Übersetzung in Gebärdensprache',
  'Zine-Produktion',
  'Bibliotheksverwaltung (Infoladen)',

  // Aktivismus & Politik
  'Antifaschistische Recherche',
  'Bündnisarbeit',
  'Demoanmeldung',
  'Versammlungsrecht / Rechtsberatung',
  'Ermittlungsausschuss (EA)',
  'Legal-Team-Koordination',
  'Antirassismus-Bildungsarbeit',
  'Feministische Bildungsarbeit',
  'Queerfeministische Organisierung',
  'Klimaaktivismus',
  'Anti-Kohle-Aktionen',
  'Tierrechtsaktivismus',
  'Mieter*innen-Organizing',
  'Gewerkschaftsarbeit',
  'Betriebsgruppenarbeit',
  'Solidaritätsarbeit mit Geflüchteten',
  'Antifa-Recherche zu Neonazi-Strukturen',
  'Sicherheitskonzepte für Veranstaltungen',
  'Aktionstraining (Blockaden)',
  'Aktionsklettern',
  'Bannermalen',
  'Siebdruck',
  'Volxküche / Küche für alle',
  'Fahrradwerkstatt (Kollektiv)',
  'Umsonstladen-Organisation',
  'Soligruppen-Koordination',
  'Prozessbeobachtung',
  'Antifaschistische Selbstverteidigung',
  'Awareness-Konzepte entwickeln',
  'Antikapitalistische Bildungsarbeit',
  'Geschichte der Arbeiter*innenbewegung',
  'Anarchistische Theorie',
  'Vernetzung mit anderen Zentren',
  'Spendenakquise / Fundraising',
  'Vereinsrecht / Gemeinnützigkeit',
  'Buchhaltung für Kollektive',
  'Konsensmoderation',
  'Plenumsprotokolle führen',
  'Soli-Partys organisieren',
  'Grenzcamp-Organisation',

  // Praktisches & Handwerk
  'Veranstaltungstechnik (PA/Sound)',
  'Lichttechnik',
  'Bühnenbau',
  'Elektroinstallation',
  'Sanitärinstallation',
  'Malerarbeiten',
  'Gebäudeinstandhaltung',
  'Nähen & Textilreparatur',
  'Urban Gardening',
  'Fermentieren & Konservieren',
  'Veganes Kochen für große Gruppen',
  'Erste Hilfe',
  'Sanitätsdienst bei Demos',
  'Second-Hand-Kleiderkammer-Organisation'
]

/**
 * Groups of thematically related skills. Used to seed skill-similarity votes
 * (see SkillAdapter's similarity graph) so that skills form recognizable
 * clusters instead of being an unconnected list - e.g. searching/matching
 * for "Linux-Administration" should also surface "Serverbetrieb / Selfhosting".
 * `authors` are the fake identities "voting" the cluster's skills as similar
 * to each other (just a plausible/thematically fitting subset of members).
 */
const SKILL_CLUSTERS = [
  {
    authors: ['id', 'jonah'],
    names: [
      'Linux-Administration', 'Windows-Systemadministration', 'Netzwerktechnik',
      'WLAN-Mesh-Netzwerke (Freifunk)', 'Serverbetrieb / Selfhosting', 'Docker & Container',
      'VPN-Einrichtung', 'Netzwerksicherheit / Monitoring', 'Kabelverlegung / Netzwerkinstallation',
      'Betriebssystem-Härtung'
    ]
  },
  {
    authors: ['id', 'jonah'],
    names: [
      'IT-Sicherheit / Firewalls', 'Penetration Testing', 'Reverse Engineering',
      'Kryptographie (PGP/GPG)', 'Tor & Onion-Services', 'Sichere Kommunikation / OpSec',
      'Digitale Selbstverteidigung (Schulungen)', 'Passwortmanager-Einrichtung', 'Verschlüsselte Backups',
      'Incident Response', 'Malware-Analyse', 'Social-Engineering-Awareness',
      'Sichere Datenträgerlöschung', 'Datenschutzberatung (DSGVO)'
    ]
  },
  {
    authors: ['id', 'jonah'],
    names: [
      'Datenbank-Administration', 'Python-Programmierung', 'JavaScript-Programmierung',
      'Webentwicklung Frontend', 'Webentwicklung Backend', 'Mobile-App-Entwicklung',
      'Bash-Scripting / Automatisierung', 'Git & Versionskontrolle', 'Datenbank-Scraping / Recherchetools',
      'Machine-Learning-Grundlagen', 'Datenvisualisierung', 'API-Entwicklung', 'Datenbank-Design'
    ]
  },
  {
    authors: ['jonah', 'id'],
    names: [
      'Nextcloud-Administration', 'Mailserver-Administration', 'CMS-Administration (WordPress etc.)',
      'Wiki-Pflege (MediaWiki)', 'Barrierefreiheit im Web', 'Open-Source-Lizenzierung'
    ]
  },
  {
    authors: ['jonah', 'mira'],
    names: [
      'Firmware-Flashing', 'Hardware-Reparatur', 'Löten',
      'Elektronik / Mikrocontroller (Arduino/Raspberry Pi)', '3D-Druck', 'CAD / Technisches Zeichnen',
      'Amateurfunk', 'Hardware-Recycling', 'Repair-Café-Elektronik',
      'SDR (Software Defined Radio)', 'Funkscanner-Technik'
    ]
  },
  {
    authors: ['kofi', 'id'],
    names: [
      'Grafikdesign (digital)', 'Videoschnitt', 'Audioproduktion / Podcast-Technik',
      'Streaming-Technik (Livestreams)', 'Foto-Dokumentation', 'Layout & Satz (Print)',
      'Flyer- & Plakatgestaltung'
    ]
  },
  {
    authors: ['kofi', 'id'],
    names: [
      'Pressearbeit', 'Öffentlichkeitsarbeit', 'Social-Media-Redaktion',
      'Newsletter-Redaktion', 'Community-Management', 'Fotojournalismus',
      'Interviewführung', 'Redaktion & Texten', 'Lektorat & Korrektorat',
      'Zine-Produktion', 'Bibliotheksverwaltung (Infoladen)'
    ]
  },
  {
    authors: ['kofi', 'lupe'],
    names: [
      'Übersetzungs-Tools / Lokalisierung', 'Übersetzen Englisch', 'Übersetzen Arabisch',
      'Übersetzen Französisch', 'Übersetzen Türkisch', 'Mehrsprachige Moderation',
      'Übersetzung in Gebärdensprache'
    ]
  },
  {
    authors: ['mira', 'id'],
    names: [
      'Moderation von Plena', 'Konfliktmoderation', 'Gewaltfreie Kommunikation',
      'Rhetorik & öffentliches Reden', 'Mediation / Vermittlung', 'Awareness-Arbeit',
      'Deeskalationstraining', 'Awareness-Konzepte entwickeln', 'Konsensmoderation',
      'Plenumsprotokolle führen', 'Veranstaltungsmoderation', 'Kinderbetreuung bei Veranstaltungen'
    ]
  },
  {
    authors: ['jonah', 'kofi'],
    names: ['Podcast-Produktion', 'Freies Radio / Radiomoderation']
  },
  {
    authors: ['lupe', 'id'],
    names: [
      'Antifaschistische Recherche', 'Versammlungsrecht / Rechtsberatung', 'Ermittlungsausschuss (EA)',
      'Legal-Team-Koordination', 'Antifa-Recherche zu Neonazi-Strukturen', 'Sicherheitskonzepte für Veranstaltungen',
      'Aktionstraining (Blockaden)', 'Aktionsklettern', 'Prozessbeobachtung',
      'Antifaschistische Selbstverteidigung'
    ]
  },
  {
    authors: ['lupe', 'kofi'],
    names: [
      'Antirassismus-Bildungsarbeit', 'Feministische Bildungsarbeit', 'Queerfeministische Organisierung',
      'Klimaaktivismus', 'Anti-Kohle-Aktionen', 'Tierrechtsaktivismus',
      'Antikapitalistische Bildungsarbeit', 'Geschichte der Arbeiter*innenbewegung', 'Anarchistische Theorie'
    ]
  },
  {
    authors: ['lupe', 'kofi'],
    names: [
      'Bündnisarbeit', 'Demoanmeldung', 'Mieter*innen-Organizing',
      'Gewerkschaftsarbeit', 'Betriebsgruppenarbeit', 'Solidaritätsarbeit mit Geflüchteten',
      'Soligruppen-Koordination', 'Vernetzung mit anderen Zentren', 'Soli-Partys organisieren',
      'Grenzcamp-Organisation'
    ]
  },
  {
    authors: ['finn', 'mira'],
    names: ['Bannermalen', 'Siebdruck', 'Nähen & Textilreparatur']
  },
  {
    authors: ['id', 'kofi'],
    names: ['Umsonstladen-Organisation', 'Spendenakquise / Fundraising', 'Vereinsrecht / Gemeinnützigkeit', 'Buchhaltung für Kollektive']
  },
  {
    authors: ['finn', 'mira'],
    names: ['Volxküche / Küche für alle', 'Urban Gardening', 'Fermentieren & Konservieren', 'Veganes Kochen für große Gruppen']
  },
  {
    authors: ['mira', 'finn'],
    names: ['Fahrradwerkstatt (Kollektiv)', 'Gebäudeinstandhaltung', 'Elektroinstallation', 'Sanitärinstallation', 'Malerarbeiten']
  },
  {
    authors: ['jonah', 'kofi'],
    names: ['Veranstaltungstechnik (PA/Sound)', 'Lichttechnik', 'Bühnenbau']
  },
  {
    authors: ['mira', 'id'],
    names: ['Erste Hilfe', 'Sanitätsdienst bei Demos']
  }
]

/**
 * Extra cross-cluster ties, so the skill graph isn't just a set of
 * disconnected islands - e.g. someone into "Klimaaktivismus" is also
 * plausibly into "Urban Gardening".
 */
const SKILL_BRIDGES = [
  { authors: ['lupe'], pair: ['Datenbank-Scraping / Recherchetools', 'Antifaschistische Recherche'] },
  { authors: ['kofi'], pair: ['Streaming-Technik (Livestreams)', 'Freies Radio / Radiomoderation'] },
  { authors: ['kofi'], pair: ['Foto-Dokumentation', 'Fotojournalismus'] },
  { authors: ['mira'], pair: ['Hardware-Reparatur', 'Fahrradwerkstatt (Kollektiv)'] },
  { authors: ['mira'], pair: ['Awareness-Arbeit', 'Erste Hilfe'] },
  { authors: ['mira'], pair: ['Deeskalationstraining', 'Sanitätsdienst bei Demos'] },
  { authors: ['lupe'], pair: ['Sicherheitskonzepte für Veranstaltungen', 'Awareness-Konzepte entwickeln'] },
  { authors: ['finn'], pair: ['Spendenakquise / Fundraising', 'Soli-Partys organisieren'] },
  { authors: ['finn'], pair: ['Bannermalen', 'Zine-Produktion'] },
  { authors: ['lupe'], pair: ['Klimaaktivismus', 'Urban Gardening'] },
  { authors: ['lupe'], pair: ['Antirassismus-Bildungsarbeit', 'Solidaritätsarbeit mit Geflüchteten'] },
  { authors: ['finn'], pair: ['Second-Hand-Kleiderkammer-Organisation', 'Umsonstladen-Organisation'] },
  { authors: ['jonah'], pair: ['WLAN-Mesh-Netzwerke (Freifunk)', 'Vernetzung mit anderen Zentren'] },
  { authors: ['jonah'], pair: ['Sichere Kommunikation / OpSec', 'Digitale Selbstverteidigung (Schulungen)'] },
  { authors: ['kofi'], pair: ['Datenschutzberatung (DSGVO)', 'Übersetzungs-Tools / Lokalisierung'] },
  { authors: ['id'], pair: ['Netzwerktechnik', 'Veranstaltungstechnik (PA/Sound)'] }
]

function randomRef (sigil, suffix) {
  return `${sigil}${crypto.randomBytes(32).toString('base64')}.${suffix}`
}

/**
 * Checks whether a query-DSL filter (as used by ssb-query/ssb-talequery, e.g.
 * `{ $filter: { value: { content: { type: { $prefix: 'talenet-' } } } } }`)
 * matches the given value. Only the small subset actually used by SSBAdapter
 * is supported: exact matches, nested objects and `$prefix`.
 */
function matchesFilter (value, filter) {
  if (!filter || typeof filter !== 'object') {
    return true
  }

  for (const key of Object.keys(filter)) {
    const expected = filter[key]
    const actual = value ? value[key] : undefined

    if (expected && typeof expected === 'object') {
      if (typeof expected.$prefix === 'string') {
        if (typeof actual !== 'string' || !actual.startsWith(expected.$prefix)) {
          return false
        }
        continue
      }
      if (!matchesFilter(actual, expected)) {
        return false
      }
      continue
    }

    if (actual !== expected) {
      return false
    }
  }

  return true
}

function matchesQuery (msg, query) {
  return (query || []).every(({ $filter }) => matchesFilter(msg, $filter))
}

export function createFakeSbot () {
  const id = randomRef('@', 'ed25519')
  const messages = []
  let sequence = 1

  // Roughly a month of history, ending "now". Each addMessage() call moves
  // the clock forward a bit so timestamps look chronologically plausible.
  let clock = Date.now() - 1000 * 60 * 60 * 24 * 30

  function tick (minMinutes, maxMinutes) {
    const minutes = minMinutes + Math.random() * (maxMinutes - minMinutes)
    clock += minutes * 60 * 1000
    return clock
  }

  function addMessage (author, type, content, timestamp) {
    const msg = {
      key: randomRef('%', 'sha256'),
      // real ssb query results carry a top-level timestamp (received order)
      // in addition to value.timestamp (claimed time) - some models
      // (Idea, IdeaComment, Identity, ...) merge updates based on this one.
      timestamp,
      value: {
        author,
        sequence: sequence++,
        timestamp,
        content: { type, ...content }
      }
    }
    messages.push(msg)
    return msg
  }

  // --- Identities -----------------------------------------------------

  const identitiesByKey = {}

  function addIdentity (key, name, description) {
    identitiesByKey[key] = { name, description }
    addMessage(key, TYPE_ABOUT, { about: key, name, description }, tick(0, 1))
  }

  addIdentity(id, 'Fake Nutzer:in', 'Nur lokale Testdaten – es ist kein SSB-Backend verbunden.')

  const mira = randomRef('@', 'ed25519')
  addIdentity(mira, 'Mira Vogt', 'Fahrradwerkstatt und Awareness-Team.')

  const jonah = randomRef('@', 'ed25519')
  addIdentity(jonah, 'Jonah Keller', 'Kümmert sich um Server, Netzwerke und Funktechnik.')

  const kofi = randomRef('@', 'ed25519')
  addIdentity(kofi, 'Kofi Owusu', 'Presse- und Öffentlichkeitsarbeit, schreibt für die Zentrumszeitung.')

  const lupe = randomRef('@', 'ed25519')
  addIdentity(lupe, 'Lupe Fernández', 'Antifaschistische Recherche und Rechtsberatung.')

  const finn = randomRef('@', 'ed25519')
  addIdentity(finn, 'Finn Brandt', 'Kocht gerne für die Volxküche und macht Siebdruck.')

  // --- Skills -----------------------------------------------------------

  const skillKeyByName = {}
  for (const name of SKILL_NAMES) {
    const msg = addMessage(id, TYPE_SKILL_CREATE, { name }, tick(0, 2))
    skillKeyByName[name] = msg.key
  }

  function assignSkillToIdentity (identityKey, skillName) {
    addMessage(identityKey, TYPE_IDENTITY_SKILL_ASSIGNMENT, {
      skillKey: skillKeyByName[skillName],
      action: ACTION_ASSIGN_SKILL
    }, tick(1, 5))
  }

  const skillsByIdentity = {
    [id]: [
      'Elektroinstallation',
      'WLAN-Mesh-Netzwerke (Freifunk)',
      'Sichere Kommunikation / OpSec',
      'Kryptographie (PGP/GPG)',
      'Datenbank-Administration',
      'Awareness-Arbeit',
      'Gewaltfreie Kommunikation',
      'Netzwerktechnik',
      'Öffentlichkeitsarbeit',
      'Fahrradwerkstatt (Kollektiv)'
    ],
    [mira]: ['Fahrradwerkstatt (Kollektiv)', 'Hardware-Reparatur', 'Awareness-Arbeit'],
    [jonah]: ['WLAN-Mesh-Netzwerke (Freifunk)', 'Netzwerktechnik', 'Amateurfunk', 'Verschlüsselte Backups'],
    [kofi]: ['Öffentlichkeitsarbeit', 'Pressearbeit', 'Social-Media-Redaktion'],
    [lupe]: ['Antifa-Recherche zu Neonazi-Strukturen', 'Versammlungsrecht / Rechtsberatung', 'Legal-Team-Koordination'],
    [finn]: ['Volxküche / Küche für alle', 'Veganes Kochen für große Gruppen', 'Siebdruck']
  }

  for (const identityKey of Object.keys(skillsByIdentity)) {
    for (const skillName of skillsByIdentity[identityKey]) {
      assignSkillToIdentity(identityKey, skillName)
    }
  }

  // Skill similarity graph: connects skills into thematic clusters, see
  // SKILL_CLUSTERS/SKILL_BRIDGES above.
  const identityByName = { id, mira, jonah, kofi, lupe, finn }

  function voteSkillsSimilar (nameA, nameB, authorNames) {
    const skillKey1 = skillKeyByName[nameA]
    const skillKey2 = skillKeyByName[nameB]
    for (const authorName of authorNames) {
      addMessage(identityByName[authorName], TYPE_SKILL_SIMILARITY, {
        skillKey1,
        skillKey2,
        similarity: SKILLS_ARE_SIMILAR
      }, tick(0, 3))
    }
  }

  for (const { authors, names } of SKILL_CLUSTERS) {
    for (let i = 0; i < names.length; i++) {
      // direct neighbours get a vote from every author of the cluster (closer,
      // as more people agree they're related); skip-one ties only get a
      // single vote (a looser, more distant connection) - this keeps each
      // cluster connected without making it a fully-meshed (and therefore
      // unrealistically uniform) graph.
      if (i + 1 < names.length) {
        voteSkillsSimilar(names[i], names[i + 1], authors)
      }
      if (i + 2 < names.length) {
        voteSkillsSimilar(names[i], names[i + 2], authors.slice(0, 1))
      }
    }
  }

  for (const { authors, pair } of SKILL_BRIDGES) {
    voteSkillsSimilar(pair[0], pair[1], authors)
  }

  // --- Ideas --------------------------------------------------------

  function createIdea ({ author, title, description, skills, associates = [], hat, comments = [] }) {
    const createMsg = addMessage(author, TYPE_IDEA_CREATE, {}, tick(60 * 6, 60 * 48))
    const ideaKey = createMsg.key

    addMessage(author, TYPE_IDEA_UPDATE, { ideaKey, title, description }, tick(1, 30))

    for (const skillName of skills) {
      addMessage(author, TYPE_IDEA_SKILL_ASSIGNMENT, {
        ideaKey,
        skillKey: skillKeyByName[skillName],
        action: ACTION_ASSIGN_SKILL
      }, tick(1, 15))
    }

    for (const associate of associates) {
      addMessage(associate, TYPE_IDEA_ASSOCIATION, {
        ideaKey,
        action: ACTION_ASSOCIATE_WITH_IDEA
      }, tick(1, 60))
    }

    if (hat) {
      addMessage(hat, TYPE_IDEA_HAT, {
        ideaKey,
        action: ACTION_TAKE_HAT
      }, tick(1, 30))
    }

    for (const comment of comments) {
      const commentMsg = addMessage(comment.author, TYPE_IDEA_COMMENT, {
        ideaKey,
        text: comment.text
      }, tick(30, 60 * 12))

      for (const reply of comment.replies || []) {
        addMessage(reply.author, TYPE_IDEA_COMMENT_REPLY, {
          ideaKey,
          commentKey: commentMsg.key,
          text: reply.text
        }, tick(10, 60 * 6))
      }
    }

    return ideaKey
  }

  createIdea({
    author: id,
    title: 'Solaranlage fürs Dach',
    description: 'Wir wollen eine Photovoltaikanlage aufs Dach bauen, um unabhängiger von Energiekonzernen zu werden und langfristig Stromkosten zu senken. Wer kennt sich mit Elektroinstallation oder Förderanträgen aus?',
    skills: ['Elektroinstallation', 'Spendenakquise / Fundraising', 'Vereinsrecht / Gemeinnützigkeit'],
    associates: [id],
    hat: id,
    comments: [
      { author: jonah, text: 'Ich kann beim Verkabeln helfen, hab schon mal eine kleine Inselanlage gebaut.' },
      { author: kofi, text: 'Ich frag mal beim Ökofonds nach, ob die sowas fördern.' }
    ]
  })

  createIdea({
    author: id,
    title: 'Offene Fahrradwerkstatt',
    description: 'Aufbau einer selbstverwalteten Fahrradwerkstatt im Hinterhof, jeden Mittwoch offen für alle im Kiez. Werkzeug ist da, uns fehlen noch helfende Hände und ein bisschen Struktur.',
    skills: ['Fahrradwerkstatt (Kollektiv)', 'Hardware-Reparatur', 'Öffentlichkeitsarbeit'],
    associates: [id, mira],
    hat: mira,
    comments: [
      { author: mira, text: 'Mittwoch 17 Uhr passt bei mir immer, können wir so festlegen.' },
      { author: finn, text: 'Ich mal noch ein Banner fürs Tor, damit man die Werkstatt findet.' }
    ]
  })

  createIdea({
    author: id,
    title: 'Verschlüsseltes Vernetzungs-Mesh mit anderen Zentren',
    description: 'Ein sicheres, dezentrales Funk-/Mesh-Netzwerk zwischen linken Zentren in der Region, damit wir auch ohne kommerziellen Internetprovider kommunizieren können - etwa bei Aktionen oder wenn das Netz mal abgeschaltet wird.',
    skills: ['WLAN-Mesh-Netzwerke (Freifunk)', 'Sichere Kommunikation / OpSec', 'Amateurfunk', 'Vernetzung mit anderen Zentren'],
    associates: [id, jonah],
    hat: jonah,
    comments: [
      {
        author: jonah,
        text: 'Hab schon zwei Freifunk-Router übrig, können wir als erste Knoten nehmen.',
        replies: [
          { author: id, text: 'Super, dann können wir am Samstag gleich mal auf dem Dach testen.' }
        ]
      }
    ]
  })

  createIdea({
    author: id,
    title: 'Volxküche jeden Freitag',
    description: 'Eine solidarische Küche für alle, jeden Freitagabend. Kochen im Kollektiv, Spende was du kannst. Uns fehlen noch Leute fürs Einkaufen, Kochen und für Awareness am Einlass.',
    skills: ['Volxküche / Küche für alle', 'Veganes Kochen für große Gruppen', 'Awareness-Arbeit'],
    associates: [id, finn],
    hat: finn,
    comments: [
      { author: finn, text: 'Einkaufen mache ich freitags vormittags, wer hilft beim Kochen ab 16 Uhr?' },
      { author: mira, text: 'Ich übernehm Freitags den Awareness-Dienst am Einlass.' }
    ]
  })

  createIdea({
    author: id,
    title: 'Antifaschistisches Archiv digitalisieren',
    description: 'Unser Recherche-Archiv zu lokalen Neonazi-Strukturen liegt seit Jahren auf Papier und alten Festplatten. Wir wollen es digitalisieren und sicher, verschlüsselt und dezentral archivieren, bevor was verloren geht.',
    skills: ['Antifa-Recherche zu Neonazi-Strukturen', 'Verschlüsselte Backups', 'Datenbank-Administration', 'Kryptographie (PGP/GPG)'],
    associates: [id, lupe],
    comments: [
      { author: lupe, text: 'Ich hab noch drei Aktenordner, die unbedingt eingescannt werden müssen.' },
      { author: jonah, text: 'Für die Backups würd ich ein verschlüsseltes NAS im Keller vorschlagen, nicht in der Cloud.' }
    ]
  })

  createIdea({
    author: id,
    title: 'Awareness-Konzept fürs Zentrum',
    description: 'Wir wollen ein verbindliches Awareness-Konzept für alle Partys und Veranstaltungen im Zentrum entwickeln und ein festes Awareness-Team aus dem Kollektiv aufbauen.',
    skills: ['Awareness-Konzepte entwickeln', 'Deeskalationstraining', 'Gewaltfreie Kommunikation'],
    associates: [id, mira],
    comments: [
      { author: mira, text: 'Es gibt gute Konzepte von anderen Zentren, ich frag mal nach Vorlagen.' },
      { author: kofi, text: 'Sollten wir das Konzept auch auf der Website veröffentlichen?' }
    ]
  })

  createIdea({
    author: id,
    title: 'Freifunk-Knoten fürs Viertel',
    description: 'Einen offenen, freien WLAN-Mesh-Knoten am Zentrum aufbauen, der auch der Nachbarschaft kostenloses Internet zur Verfügung stellt - unabhängig und zensurresistent.',
    skills: ['WLAN-Mesh-Netzwerke (Freifunk)', 'Netzwerktechnik', 'Kabelverlegung / Netzwerkinstallation'],
    associates: [id, jonah],
    hat: id,
    comments: [
      { author: jonah, text: 'Antenne müsste aufs Dach, hab da schon einen Halterungsvorschlag.' },
      { author: kofi, text: 'Das wäre auch eine schöne Meldung für den nächsten Newsletter.' }
    ]
  })

  // --- sbot RPC surface used by SSBAdapter -------------------------------

  return {
    id,

    messagesByType (opts) {
      const type = opts && opts.type
      return pull.values(messages.filter(m => m.value.content.type === type))
    },

    query: {
      read (opts) {
        const query = opts && opts.query
        return pull.values(messages.filter(m => matchesQuery(m, query)))
      },
      explain (opts, cb) {
        cb(null, 'fake query, no real explain available')
      }
    },

    talequery: {
      read (opts) {
        const query = opts && opts.query
        return pull.values(messages.filter(m => matchesQuery(m, query)))
      }
    },

    about: {
      stream () {
        // one flatmap-able entry containing all known identity keys, see
        // SSBAdapter.streamAbouts()
        const allKeys = {}
        for (const key of Object.keys(identitiesByKey)) {
          allKeys[key] = true
        }
        return pull.values([allKeys])
      },
      get (cb) {
        const about = {}
        for (const key of Object.keys(identitiesByKey)) {
          const { name, description } = identitiesByKey[key]
          about[key] = {
            name: { [key]: [name] },
            description: { [key]: [description] }
          }
        }
        cb(null, about)
      }
    },

    private: {
      read () {
        return pull.empty()
      },
      publish (msg, recps, cb) {
        cb(null, addMessage(id, msg.type, msg, Date.now()))
      }
    },

    friends: {
      get (opts, cb) {
        cb(null, {})
      }
    },

    invite: {
      accept (code, cb) {
        cb(new Error('Fake-Modus: Einladungen werden nicht unterstützt.'))
      }
    },

    blobs: {
      add (cb) {
        cb(new Error('Fake-Modus: Datei-Uploads werden nicht unterstützt.'))
      }
    },

    links () {
      return pull.empty()
    },

    status (cb) {
      cb(null, {
        sync: { sync: true },
        progress: { indexes: { target: 0, current: 0 } },
        gossip: {}
      })
    },

    get (key, cb) {
      const msg = messages.find(m => m.key === key)
      if (!msg) {
        return cb(new Error('Fake-Modus: Nachricht nicht gefunden: ' + key))
      }
      cb(null, msg.value)
    },

    publish (msg, cb) {
      cb(null, addMessage(id, msg.type, msg, Date.now()))
    },

    on () {
      // no real connection events in fake mode
    }
  }
}
