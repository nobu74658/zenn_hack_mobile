# Database Structure Documentation

## Overview
This document outlines the comprehensive data structure for the English learning mobile application based on TypeScript definitions from the frontend repository.

## Core Data Models

### 1. Word Entity
**Purpose**: Represents a single English word with its core information
```
Word
├── wordId: string (Primary Key)
├── word: string (The actual word)
├── coreMeaning: string (Primary definition)
└── explanation: string (Detailed explanation)
```

### 2. Meaning Entity
**Purpose**: Represents different meanings/uses of a word
```
Meaning
├── meaningId: string (Primary Key)
├── pos: enum (Part of Speech)
│   ├── "noun"
│   ├── "pronoun"
│   ├── "intransitiveVerb"
│   ├── "transitiveVerb"
│   ├── "adjective"
│   ├── "adverb"
│   ├── "preposition"
│   ├── "conjunction"
│   └── "interjection"
├── translation: string (Translated meaning)
├── pronunciation: string (Pronunciation guide)
├── exampleEng: string (English example sentence)
└── exampleJpn: string (Japanese example sentence)
```

### 3. Media Entity
**Purpose**: Stores multimedia content associated with word meanings
```
Media
├── mediaId: string (Primary Key)
├── meaningId: string (Foreign Key → Meaning.meaningId)
└── mediaUrls: string[] (Array of media file URLs)
```

### 4. Flashcard Entity (Main Aggregate)
**Purpose**: Central entity combining word, meanings, and user data
```
Flashcard
├── flashcardId: string (Primary Key)
├── word: Word (Embedded/Referenced Word object)
├── meanings: Meaning[] (Array of related meanings)
├── media: Media (Associated media content)
├── memo: string (User's personal notes)
└── checkFlag: boolean (Completion/mastery status)
```

### 5. Template Entity
**Purpose**: Predefined templates for content generation
```
Template
├── templateId: string (Primary Key)
├── name: string (Template name)
├── description: string (Template description)
├── generationType: string (Type of content generation)
└── promptText: string (Generation prompt)
```

### 6. Comparison Entity
**Purpose**: Tracks media comparison selections
```
Comparison
├── comparisonId: string (Primary Key)
├── oldMediaId: string (Foreign Key → Media.mediaId)
├── newMediaId: string (Foreign Key → Media.mediaId)
└── selected: string (User's selection result)
```

## Entity Relationships

### Primary Relationships
```
Flashcard ──┐
            ├── 1:1 → Word
            ├── 1:n → Meaning
            └── 1:1 → Media

Media ──── n:1 → Meaning (via meaningId)

Comparison ──┐
             ├── n:1 → Media (oldMediaId)
             └── n:1 → Media (newMediaId)

Template (Independent entity)
```

### Detailed Relationship Mapping
1. **Flashcard → Word**: One-to-one composition
2. **Flashcard → Meaning**: One-to-many composition
3. **Flashcard → Media**: One-to-one composition
4. **Media → Meaning**: Many-to-one reference
5. **Comparison → Media**: Many-to-one reference (both old and new)

## Data Flow Architecture

### Learning Flow
```
1. Word Creation
   └── Define basic word information

2. Meaning Assignment
   └── Add multiple meanings with examples

3. Media Generation
   └── Create visual/audio content for meanings

4. Flashcard Assembly
   └── Combine word + meanings + media + user data

5. Learning Process
   └── User studies flashcard and updates memo/checkFlag
```

### Content Generation Flow
```
1. Template Selection
   └── Choose generation parameters

2. Media Creation
   └── Generate content based on template

3. Comparison Process
   └── Compare different media versions

4. Selection Integration
   └── Apply selected media to flashcard
```

## Implementation Considerations

### Database Design Recommendations

1. **Primary Keys**: All entities use string-based UUIDs for global uniqueness
2. **Referential Integrity**: Ensure foreign key constraints between Media→Meaning
3. **Data Validation**: All fields are required (no nullable fields in current design)
4. **Indexing Strategy**:
   - Index on `wordId` for fast word lookups
   - Index on `meaningId` for media associations
   - Index on `checkFlag` for progress tracking

### Flutter Implementation Mapping

1. **Domain Models**: Map TypeScript interfaces to Freezed models
2. **Repository Pattern**: Create repositories for each major entity
3. **JSON Serialization**: Add Freezed/JSON annotations for API communication
4. **Validation**: Implement field validation matching TypeScript constraints

### API Endpoint Mapping
```
Flashcard Management:
- GET /flashcard/{userId} → List<Flashcard>
- PUT /flashcard/checkFlag → Update completion status
- GET /flashcard/{wordId} → List<Meaning>
- PUT /flashcard/meaning → Add meanings to flashcard
- PUT /flashcard/memo → Update user notes

Template & Media:
- GET /template → List<Template>
- POST /media → Create Media from template
- POST /comparison → Create comparison between media
```

## Migration Strategy

### Phase 1: Core Models
1. Implement Word, Meaning, Media entities
2. Create basic Flashcard aggregate
3. Add JSON serialization

### Phase 2: Advanced Features
1. Implement Template system
2. Add Comparison functionality
3. Create media generation pipeline

### Phase 3: Optimization
1. Add caching strategies
2. Implement offline support
3. Add performance indexes

## Validation Rules

### Word Entity
- `wordId`: Non-empty string, unique
- `word`: Non-empty string
- `coreMeaning`: Non-empty string
- `explanation`: Non-empty string

### Meaning Entity
- `meaningId`: Non-empty string, unique
- `pos`: Must be one of the predefined enum values
- All text fields: Non-empty strings

### Media Entity
- `mediaId`: Non-empty string, unique
- `meaningId`: Must reference existing Meaning
- `mediaUrls`: Non-empty array with valid URLs

### Flashcard Entity
- `flashcardId`: Non-empty string, unique
- `word`: Valid Word object
- `meanings`: Non-empty array of valid Meaning objects
- `media`: Valid Media object
- `memo`: String (can be empty)
- `checkFlag`: Boolean value

This structure provides a comprehensive foundation for implementing the English learning mobile application with proper data modeling and relationships.