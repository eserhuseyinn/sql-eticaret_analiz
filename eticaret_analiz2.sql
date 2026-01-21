--choose nin içine ay yazdýðýmýz için sýralý þekilde bize aylarý okunacak forma çevridi

--1. ANALÝZ: Ay Bazlý Satýþ ve Adet Trendi
SELECT 
    CHOOSE(MONTH(s.siparis_tarihi), 'Ocak', 'Þubat', 'Mart', 'Nisan', 'Mayýs') AS Ay_Adi,
    u.urun_adi,
    SUM(sd.adet) AS Toplam_Adet,
    SUM(sd.satir_toplam) AS Toplam_Ciro
FROM siparis s
JOIN siparis_detay sd ON s.siparis_id = sd.siparis_id
JOIN urun u ON sd.urun_id = u.urun_id
GROUP BY MONTH(s.siparis_tarihi), u.urun_adi
ORDER BY MONTH(s.siparis_tarihi) ASC, Toplam_Ciro DESC;



--2. ANALÝZ: Þehir ve Müþteri Segmenti Daðýlýmý
select sehir, musteri_segmenti, count('ad'+'soyad') as MÜÞTERÝ_SAYISI from musteri
GROUP BY sehir,musteri_segmenti
order by sehir


-- 3. ANALÝZ: Detaylý Ürün ve Bölge Matrisi
SELECT 
    m.sehir, 
    m.musteri_segmenti, 
    u.urun_adi, 
    SUM(sd.adet) AS Toplam_Adet
FROM musteri m
JOIN siparis s ON m.musteri_id = s.musteri_id 
JOIN siparis_detay sd ON s.siparis_id = sd.siparis_id 
JOIN urun u ON sd.urun_id = u.urun_id
GROUP BY m.sehir, m.musteri_segmenti, u.urun_adi
ORDER BY m.sehir, Toplam_Adet DESC;