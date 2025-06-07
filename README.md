## 🔧 Kā palaist spēli

Lai palaistu spēli, izpildiet šos soļus:

1. Klonējiet šo repozitoriju vai lejupielādējiet ZIP arhīvu:
   - Ja klonējat:  
     ```bash
     git clone https://github.com/Malekitos/survive-protocol
     ```
   - Vai lejupielādējiet `.zip` un atarhivējiet to savā datorā.

2. Pēc projekta atarhivēšanas, atveriet projekta mapi.

3. Iekšējā mapē `BIN` atradīsiet mapes:
   - `Windows` — ja izmantojat Windows operētājsistēmu;
   - `Linux` — ja izmantojat Linux.

4. Atveriet atbilstošo mapi un palaidiet tajā esošo izpildāmo failu, lai sāktu spēli.


# 🕹️ 2D Izdzīvošanas Spēle

Šajā 2D izdzīvošanas spēlē spēlētāja galvenais uzdevums ir **izdzīvot pēc iespējas ilgāk** un uzstādīt savu rekordu, ar kuru pēc tam var lepoties draugu priekšā.


## 🌍 Procedurāli Ģenerēta Pasaule

Katru reizi, kad sākat spēli, tiek ģenerēta jauna pasaule, izmantojot **Perlin trokšņa algoritmu**, kas nodrošina unikālu pieredzi katrā spēlē.


## 🌞 Dienas un Nakts Cikls

- **Dienā** spēlētājs vāc resursus, kas nepieciešami izdzīvošanai.  
- **Naktī** jāaizsargājas no pretiniekiem, kuri uzbrūk spēlētājam.


## ⛏️ Šahtas

- Uz kartes iespējams atrast ieejas šahtās.
- Kad spēlētājs ieiet šahtā, šī ieeja tiek slēgta un tajā **vairs nevar atgriezties**.
- Šahtas tiek ģenerētas procedurāli — **katra no tām ir unikāla**.
- Iespējams iegūt **vērtīgus resursus**.
- Katrā šahtā ir viens vai vairāki **izejas punkti**.
- Izejot no šahtas, spēlētājs **atgriežas virszemes pasaulē**.


## 🎒 Inventārs un Kraftešana

- Inventāra sistēmu var atvērt, nospiežot `TAB`.
- Ja spēlētājam ir pietiekams daudzums noteiktu resursu, kļūst pieejamas **kraftešanas iespējas** — iespējams izveidot jaunus objektus no savāktajiem materiāliem.
- Apakšējā daļā atrodas **hotbar**, kas ļauj ātri piekļūt noderīgiem priekšmetiem vai ieročiem.


## ⚒️ Kraftešanas Sistēma un Priekšmetu Līmeņi

- Ir iespējams izveidot dažādus **instrumentus**, piemēram:
  - **zobeni** — paredzēti cīņai ar pretiniekiem,
  - **kirkas** — efektīvai resursu ieguvei no akmens vai rūdām,
  - **cirvji** — ātrākai koku ciršanai un resursu vākšanai.
- Izveidojot atbilstošu instrumentu:
  - tiek **palielināts iegūšanas ātrums** konkrētajam resursam,
  - tiek **palielināts uzbrukuma spēks** pretiniekiem.

### 🔼 Priekšmetu Līmeņi

- Katram priekšmetam ir **vairāki uzlabojumu līmeņi**.
- Piemēram:
  - **Koka zobens** ir **1. līmeņa** ierocis, kas tiek kraftēts no **koka un akmens**.
  - Lai izveidotu **akmens zobenu** (**2. līmenis**), vispirms **jāizveido koka zobens**.
- **Nav iespējams izlaist līmeņus** — progress notiek **pakāpeniski**, soli pa solim.


## 🩸 Dzīvības un Bruņas Sistēma

- Uzsākot **cīņu** ar pretiniekiem vai **iegūstot resursus**, tiek rādīts to **atlikušais HP**.
- Spēlētāja statuss redzams ekrāna apakšā:
  - 🟩 **Zaļa josla** — veselība.
  - 🟦 **Zila josla** — bruņas.
- Sākumā bruņu nav, tāpēc zila josla **nav redzama**.
- Kad tiek izgatavotas bruņas, zila josla **pakāpeniski aizpildās**.
- Jo vairāk bruņu, **jo mazāk kaitējuma** spēlētājs saņem no ienaidniekiem.


## 💾 Automātiska Saglabāšana un Atgriešanās

- Izejot no spēles pasaules, **tā tiek automātiski saglabāta**.
- Pat ja spēli aizver pilnībā, nospiežot pogu **Resume Game**, jūs atgriezīsieties **tieši tajā pašā vietā**, kur pārtraucāt spēli.
- Saglabājas ne tikai atrašanās vieta, bet arī visi jūsu **resursi, stāvokļi un progres**.


## 📘 Instrukciju Sadaļa

- Spēles galvenajā izvēlnē pieejama sadaļa ar **instrukcijām**, kur aprakstīts:
  - Kā sākt spēli,
  - Kā izdzīvot un efektīvi vākt resursus,
  - Kā izmantot spēles sistēmas, piemēram, **inventāru, kraftešanu, cīņu** utt.


## 🎯 Mērķis

Izdzīvot pēc iespējas ilgāk, **gudri pārvaldot resursus**, aizsargājoties no briesmām un uzstādot jaunu **personīgo rekordu**!


![Screenshot From 2025-05-31 18-32-42](https://github.com/user-attachments/assets/91a95fef-8ac6-437c-8093-e171e40b80de)
![Screenshot From 2025-05-31 18-32-24](https://github.com/user-attachments/assets/20eb11d6-bfb6-403f-a312-5aaec3c95ce0)
![Screenshot From 2025-05-31 18-30-14](https://github.com/user-attachments/assets/a1769b8d-b05c-488a-8e2e-47a96a4a19f7)
![image](https://github.com/user-attachments/assets/c12ced67-96fa-479b-aab6-a323f31920ee)
![Screenshot From 2025-05-31 18-29-16](https://github.com/user-attachments/assets/9abb83b1-c100-4486-be20-1193aeecd8ee)
![Screenshot From 2025-05-31 18-28-59](https://github.com/user-attachments/assets/bc91394c-867f-4a0b-9b11-6d94683cfcf7)
![Screenshot From 2025-05-31 18-28-46](https://github.com/user-attachments/assets/d20f4ee5-bd19-4d03-ac1d-b3e17d2dba35)
![Screenshot From 2025-05-31 18-28-23](https://github.com/user-attachments/assets/02d73223-21d9-419f-b7f9-37b32407e179)
![Screenshot From 2025-05-31 18-28-09](https://github.com/user-attachments/assets/079563a2-beeb-48d7-9f17-97e8443b2199)
![Screenshot From 2025-05-31 18-27-35](https://github.com/user-attachments/assets/1badf228-66d7-4dfd-a5ae-af4fd1c146ae)
![Screenshot From 2025-05-31 18-27-30](https://github.com/user-attachments/assets/008b6f09-c1c9-4b7b-adb7-4b4f65361146)
![Screenshot From 2025-05-31 18-42-22](https://github.com/user-attachments/assets/2c66ae8e-6c8d-42a3-a0dd-cbc100faf4af)



