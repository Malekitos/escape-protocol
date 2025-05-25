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

---

## 🌍 Procedurāli Ģenerēta Pasaule

Katru reizi, kad sākat spēli, tiek ģenerēta jauna pasaule, izmantojot **Perlin trokšņa algoritmu**, kas nodrošina unikālu pieredzi katrā spēlē.

---

## 🌞 Dienas un Nakts Cikls

- **Dienā** spēlētājs vāc resursus, kas nepieciešami izdzīvošanai.  
- **Naktī** jāaizsargājas no pretiniekiem, kuri uzbrūk spēlētājam.

---

## ⛏️ Šahtas

- Uz kartes iespējams atrast ieejas šahtās.
- Kad spēlētājs ieiet šahtā, šī ieeja tiek slēgta un tajā **vairs nevar atgriezties**.
- Šahtas tiek ģenerētas procedurāli — **katra no tām ir unikāla**.
- Iespējams iegūt **vērtīgus resursus**.
- Katrā šahtā ir viens vai vairāki **izejas punkti**.
- Izejot no šahtas, spēlētājs **atgriežas virszemes pasaulē**.

---

## 🎒 Inventārs un Kraftešana

- Inventāra sistēmu var atvērt, nospiežot `TAB`.
- Ja spēlētājam ir pietiekams daudzums noteiktu resursu, kļūst pieejamas **kraftešanas iespējas** — iespējams izveidot jaunus objektus no savāktajiem materiāliem.
- Apakšējā daļā atrodas **hotbar**, kas ļauj ātri piekļūt noderīgiem priekšmetiem vai ieročiem.

---

## 🩸 Dzīvības un Bruņas Sistēma

- Uzsākot **cīņu** ar pretiniekiem vai **iegūstot resursus**, tiek rādīts to **atlikušais HP**.
- Spēlētāja statuss redzams ekrāna apakšā:
  - 🟩 **Zaļa josla** — veselība.
  - 🟦 **Zila josla** — bruņas.
- Sākumā bruņu nav, tāpēc zila josla **nav redzama**.
- Kad tiek izgatavotas bruņas, zila josla **pakāpeniski aizpildās**.
- Jo vairāk bruņu, **jo mazāk kaitējuma** spēlētājs saņem no ienaidniekiem.

---

## 💾 Automātiska Saglabāšana un Atgriešanās

- Izejot no spēles pasaules, **tā tiek automātiski saglabāta**.
- Pat ja spēli aizver pilnībā, nospiežot pogu **Resume Game**, jūs atgriezīsieties **tieši tajā pašā vietā**, kur pārtraucāt spēli.
- Saglabājas ne tikai atrašanās vieta, bet arī visi jūsu **resursi, stāvokļi un progres**.

---

## 🎯 Mērķis

Izdzīvot pēc iespējas ilgāk, **gudri pārvaldot resursus**, aizsargājoties no briesmām un uzstādot jaunu **personīgo rekordu**!

---


![Screenshot From 2025-05-16 19-06-48](https://github.com/user-attachments/assets/f9f476b9-6f35-4c1c-9b5e-88b074e7293a)
![Screenshot From 2025-05-25 17-20-06](https://github.com/user-attachments/assets/634e4f71-0630-4e99-bef0-f5c6aee03550)
![Screenshot From 2025-05-25 17-19-54](https://github.com/user-attachments/assets/75efcc9d-767c-4b22-8cca-7a2970a6f3ad)
![Screenshot From 2025-05-16 18-32-24](https://github.com/user-attachments/assets/d0d86ffc-03de-411a-811d-4b91d560ddee)


