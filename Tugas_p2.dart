class Karyawan {
  String nip;
  String nama;
  String divisi;
  double? gajiPokok;
  double tunjangan;

  Karyawan({
    required this.nip,
    required this.nama,
    required this.divisi,
    required this.gajiPokok,
    required this.tunjangan,
  });
}

// ============================================================
// CUSTOM EXCEPTION
// ============================================================

class DataKaryawanException implements Exception {
  String pesan;

  DataKaryawanException(this.pesan);

  @override
  String toString() {
    return pesan;
  }
}

// ============================================================
// FUNGSI MENCARI KARYAWAN
// Menggunakan null safety
// ============================================================

Karyawan? cariKaryawan(
  List<Karyawan> daftarKaryawan,
  String nip,
) {
  for (var karyawan in daftarKaryawan) {
    if (karyawan.nip == nip) {
      return karyawan;
    }
  }

  return null;
}

// ============================================================
// FUNGSI CEK NIP DUPLIKAT
// ============================================================

void cekNIPDuplikat(List<Karyawan> daftarKaryawan) {
  Set<String> nipTerdaftar = {};

  for (var karyawan in daftarKaryawan) {
    if (nipTerdaftar.contains(karyawan.nip)) {
      throw DataKaryawanException(
        'NIP duplikat ditemukan: ${karyawan.nip}',
      );
    }

    nipTerdaftar.add(karyawan.nip);
  }
}

// ============================================================
// FUNGSI BPJS
// BPJS = 3% dari gaji pokok
// ============================================================

double hitungBPJS(double gajiPokok) {
  return gajiPokok * 0.03;
}

// ============================================================
// FUNGSI PPH BERDASARKAN BRACKET
// ============================================================

double hitungPPh(double penghasilanKotor) {
  if (penghasilanKotor <= 5000000) {
    return 0;
  } else if (penghasilanKotor <= 10000000) {
    return penghasilanKotor * 0.05;
  } else if (penghasilanKotor <= 20000000) {
    return penghasilanKotor * 0.10;
  } else {
    return penghasilanKotor * 0.15;
  }
}

// ============================================================
// FUNGSI MENGHITUNG GAJI BERSIH
// ============================================================

double hitungGajiBersih(Karyawan karyawan) {
  // Mengecek apakah gaji pokok null
  if (karyawan.gajiPokok == null) {
    throw DataKaryawanException(
      'Gaji pokok karyawan ${karyawan.nama} tidak boleh null.',
    );
  }

  double gajiPokok = karyawan.gajiPokok!;

  double tunjangan = karyawan.tunjangan;

  double penghasilanKotor =
      gajiPokok + tunjangan;

  double bpjs = hitungBPJS(gajiPokok);

  double pph = hitungPPh(penghasilanKotor);

  double gajiBersih =
      penghasilanKotor - bpjs - pph;

  return gajiBersih;
}

// ============================================================
// FORMAT RUPIAH
// ============================================================

String rupiah(double angka) {
  return 'Rp ${angka.toStringAsFixed(0)}';
}

// ============================================================
// MAIN PROGRAM
// ============================================================

void main() {
  // ==========================================================
  // DATA 10 KARYAWAN
  // ==========================================================

  List<Karyawan> daftarKaryawan = [
    Karyawan(
      nip: '100001',
      nama: 'Andi',
      divisi: 'IT',
      gajiPokok: 8000000,
      tunjangan: 1000000,
    ),

    Karyawan(
      nip: '100002',
      nama: 'Budi',
      divisi: 'Marketing',
      gajiPokok: 7000000,
      tunjangan: 800000,
    ),

    Karyawan(
      nip: '100003',
      nama: 'Citra',
      divisi: 'Keuangan',
      gajiPokok: 9000000,
      tunjangan: 1200000,
    ),

    Karyawan(
      nip: '100004',
      nama: 'Dinda',
      divisi: 'HRD',
      gajiPokok: 6000000,
      tunjangan: 700000,
    ),

    Karyawan(
      nip: '100005',
      nama: 'Eko',
      divisi: 'IT',
      gajiPokok: 12000000,
      tunjangan: 1500000,
    ),

    Karyawan(
      nip: '100006',
      nama: 'Fajar',
      divisi: 'Produksi',
      gajiPokok: 5500000,
      tunjangan: 500000,
    ),

    Karyawan(
      nip: '100007',
      nama: 'Gina',
      divisi: 'Marketing',
      gajiPokok: 10000000,
      tunjangan: 1000000,
    ),

    Karyawan(
      nip: '100008',
      nama: 'Hendra',
      divisi: 'IT',
      gajiPokok: 15000000,
      tunjangan: 2000000,
    ),

    Karyawan(
      nip: '100009',
      nama: 'Intan',
      divisi: 'Keuangan',
      gajiPokok: 11000000,
      tunjangan: 1300000,
    ),

    Karyawan(
      nip: '100010',
      nama: 'Joko',
      divisi: 'HRD',
      gajiPokok: 5000000,
      tunjangan: 600000,
    ),
  ];

  // ==========================================================
  // JUDUL PROGRAM
  // ==========================================================

  print('');
  print('============================================================');
  print('             SISTEM MANAJEMEN PENGGAJIAN');
  print('============================================================');

  // ==========================================================
  // CEK NIP DUPLIKAT
  // ==========================================================

  try {
    cekNIPDuplikat(daftarKaryawan);

    print('');
    print('[✓] Pemeriksaan NIP berhasil.');
    print('[✓] Tidak ditemukan NIP duplikat.');
  } on DataKaryawanException catch (e) {
    print('');
    print('[ERROR] $e');
  }

  // ==========================================================
  // PERHITUNGAN PAYROLL
  // ==========================================================

  double totalPayroll = 0;
  double gajiTertinggi = 0;
  double gajiTerendah = double.infinity;

  Karyawan? karyawanTertinggi;
  Karyawan? karyawanTerendah;

  print('');
  print('============================================================');
  print('                  DATA PENGGAJIAN');
  print('============================================================');

  for (var karyawan in daftarKaryawan) {
    try {
      double gajiBersih = hitungGajiBersih(karyawan);

      double gajiPokok = karyawan.gajiPokok!;

      double bpjs = hitungBPJS(gajiPokok);

      double penghasilanKotor =
          gajiPokok + karyawan.tunjangan;

      double pph = hitungPPh(penghasilanKotor);

      totalPayroll += gajiBersih;

      // Menentukan gaji tertinggi
      if (gajiBersih > gajiTertinggi) {
        gajiTertinggi = gajiBersih;
        karyawanTertinggi = karyawan;
      }

      // Menentukan gaji terendah
      if (gajiBersih < gajiTerendah) {
        gajiTerendah = gajiBersih;
        karyawanTerendah = karyawan;
      }

      print('');
      print('NIP             : ${karyawan.nip}');
      print('Nama            : ${karyawan.nama}');
      print('Divisi          : ${karyawan.divisi}');
      print('Gaji Pokok      : ${rupiah(gajiPokok)}');
      print('Tunjangan       : ${rupiah(karyawan.tunjangan)}');
      print('BPJS 3%         : ${rupiah(bpjs)}');
      print('PPh             : ${rupiah(pph)}');
      print('Gaji Bersih     : ${rupiah(gajiBersih)}');
      print('------------------------------------------------------------');
    } on DataKaryawanException catch (e) {
      print('[ERROR] $e');
    }
  }

  // ==========================================================
  // LAPORAN PAYROLL
  // ==========================================================

  double rataRata =
      totalPayroll / daftarKaryawan.length;

  print('');
  print('============================================================');
  print('                    LAPORAN PAYROLL');
  print('============================================================');

  print('Jumlah Karyawan : ${daftarKaryawan.length}');
  print('Total Payroll   : ${rupiah(totalPayroll)}');
  print('Rata-rata Gaji  : ${rupiah(rataRata)}');

  print(
    'Gaji Tertinggi  : ${rupiah(gajiTertinggi)}'
    ' - ${karyawanTertinggi?.nama}',
  );

  print(
    'Gaji Terendah   : ${rupiah(gajiTerendah)}'
    ' - ${karyawanTerendah?.nama}',
  );

  // ==========================================================
  // PENCARIAN KARYAWAN - NIP DITEMUKAN
  // ==========================================================

  print('');
  print('============================================================');
  print('                  PENCARIAN KARYAWAN');
  print('============================================================');

  String nipDicari = '100005';

  Karyawan? hasilPencarian =
      cariKaryawan(daftarKaryawan, nipDicari);

  if (hasilPencarian != null) {
    print('[✓] Karyawan ditemukan.');
    print('NIP       : ${hasilPencarian.nip}');
    print('Nama      : ${hasilPencarian.nama}');
    print('Divisi    : ${hasilPencarian.divisi}');
    print(
      'Gaji Pokok: '
      '${rupiah(hasilPencarian.gajiPokok ?? 0)}',
    );
  } else {
    print(
      '[INFO] Karyawan dengan NIP '
      '$nipDicari tidak ditemukan.',
    );
  }

  // ==========================================================
  // PENCARIAN KARYAWAN - NIP TIDAK DITEMUKAN
  // ==========================================================

  String nipTidakAda = '999999';

  Karyawan? hasilTidakAda =
      cariKaryawan(daftarKaryawan, nipTidakAda);

  if (hasilTidakAda != null) {
    print('');
    print('[✓] Karyawan ditemukan.');
    print('Nama: ${hasilTidakAda.nama}');
  } else {
    print('');
    print(
      '[INFO] Karyawan dengan NIP '
      '$nipTidakAda tidak ditemukan.',
    );
  }

  // ==========================================================
  // TEST EXCEPTION GAJI NULL
  // ==========================================================

  print('');
  print('============================================================');
  print('              TEST EXCEPTION GAJI NULL');
  print('============================================================');

  Karyawan karyawanGajiNull = Karyawan(
    nip: 'TEST001',
    nama: 'Karyawan Test Null',
    divisi: 'Testing',
    gajiPokok: null,
    tunjangan: 500000,
  );

  try {
    hitungGajiBersih(karyawanGajiNull);

    print('[ERROR] Exception gaji null tidak terdeteksi.');
  } on DataKaryawanException catch (e) {
    print('[✓] Exception berhasil ditangani.');
    print('Pesan: $e');
  }

  // ==========================================================
  // TEST EXCEPTION NIP DUPLIKAT
  // ==========================================================

  print('');
  print('============================================================');
  print('              TEST EXCEPTION NIP DUPLIKAT');
  print('============================================================');

  List<Karyawan> dataDenganNIPDuplikat = [
    Karyawan(
      nip: 'TEST100',
      nama: 'Karyawan A',
      divisi: 'IT',
      gajiPokok: 5000000,
      tunjangan: 500000,
    ),

    Karyawan(
      nip: 'TEST100',
      nama: 'Karyawan B',
      divisi: 'HRD',
      gajiPokok: 6000000,
      tunjangan: 500000,
    ),
  ];

  try {
    cekNIPDuplikat(dataDenganNIPDuplikat);

    print('[ERROR] NIP duplikat tidak terdeteksi.');
  } on DataKaryawanException catch (e) {
    print('[✓] Exception berhasil ditangani.');
    print('Pesan: $e');
  }

  // ==========================================================
  // PROGRAM SELESAI
  // ==========================================================

  print('');
  print('============================================================');
  print('              PROGRAM SELESAI DIJALANKAN');
  print('============================================================');
}