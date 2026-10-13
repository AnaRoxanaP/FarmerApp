# Stâna noastră

Aplicație mobilă Expo pentru evidența oilor din gospodărie. Interfața este în română, iar datele rămân pe dispozitiv într-o bază SQLite.

## Ce poate face

- Păstrează numele/descrierea, sexul, rasa, semnul distinctiv și crotaliul fiecărui animal.
- Înregistrează fătări; fiecare miel intră automat în turmă și păstrează legătura cu mama, data nașterii, rasa, sexul și crotaliul.
- Înregistrează tratamente, doză și observații; o reamintire opțională programează o notificare locală.
- Deschide fișa unui animal pentru a consulta istoricul fătărilor și tratamentelor.

## Pornire

Proiectul folosește Expo SDK 57, compatibil cu Expo Go SDK 57.

În PowerShell, din folderul proiectului:

1. Instalează dependențele cu `npm.cmd install`.
2. Potrivește versiunile modulelor Expo cu SDK-ul folosind `npx.cmd expo install --fix`.
3. Pornește Metro cu `npx.cmd expo start`.
4. Scanează codul QR din Expo Go pe Android sau iOS ori deschide un emulator configurat.

La prima pornire se adaugă trei animale demonstrative. Notificările necesită permisiune și funcționează pe un dispozitiv compatibil. Semnele sunt momentan descrieri text; catalogul grafic poate fi adăugat separat.
