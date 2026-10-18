import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chanthaburi Favorite Places',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: const Color(0xFFF1F8E9),
      ),
      home: const FavoritePlaceScreen(),
    );
  }
}

// 1. เปลี่ยนจาก StatelessWidget เป็น StatefulWidget เพื่อให้หน้าจอสามารถจดจำและเปลี่ยนแปลงสถานะได้ (Interactivity)
class FavoritePlaceScreen extends StatefulWidget {
  const FavoritePlaceScreen({super.key});

  @override
  State<FavoritePlaceScreen> createState() => _FavoritePlaceScreenState();
}

class _FavoritePlaceScreenState extends State<FavoritePlaceScreen> {
  // 2. กำหนดตัวแปร State (สถานะเริ่มต้น)
  bool _isFavorited = true; // สถานะการกดถูกใจ (เริ่มต้นเป็น true คือกดไลก์แล้ว)
  int _favoriteCount = 41;   // ตัวเลขจำนวนยอดไลก์เริ่มต้น

  // 3. ฟังก์ชันสำหรับจัดการการกดปุ่ม (เมื่อผู้ใช้กดปุ่มหัวใจ)
  void _toggleFavorite() {
    setState(() {
      // ฟังก์ชัน setState จะบอกให้ Flutter ทำการวาดหน้าจอใหม่ (Re-render UI) ทันทีที่มีการเปลี่ยนค่า
      if (_isFavorited) {
        _favoriteCount -= 1; // ถ้าเคยไลก์อยู่ ให้ลดจำนวนลง 1
        _isFavorited = false; // เปลี่ยนสถานะเป็นยังไม่ไลก์
      } else {
        _favoriteCount += 1; // ถ้ายังไม่ไลก์ ให้เพิ่มจำนวนขึ้น 1
        _isFavorited = true;  // เปลี่ยนสถานะเป็นไลก์แล้ว
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Flutter Interactivity (w03)',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF2E7D32),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ส่วนแถบแสดงชื่อและรหัสนักศึกษาของผู้จัดทำ
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              color: const Color(0xFF1B5E20),
              child: const Text(
                'ผู้จัดทำ: 6714421035 ธนากร เสนามนตรี',
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xFFFFB300), fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
            
            // ส่วนภาพจำลองสถานที่ท่องเที่ยว
            Container(
              height: 250,
              width: double.infinity,
              color: Colors.green.shade200,
              child: const Icon(
                Icons.landscape,
                size: 100,
                color: Color(0xFF2E7D32),
              ),
            ),

            // ส่วนเนื้อหาหลัก (Title & Action Section ตาม Flutter Tutorial)
            Container(
              padding: const EdgeInsets.all(24.0),
              color: Colors.white,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'จุดชมวิวและธรรมชาติ น้ำตกพลิ้ว',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1B5E20),
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              'อำเภอแหลมสิงห์, จังหวัดจันทบุรี',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      // 4. ปุ่มกดโต้ตอบ Favorite Widget (ไอคอนรูปหัวใจ)
                      IconButton(
                        padding: EdgeInsets.zero,
                        alignment: Alignment.centerRight,
                        icon: Icon(
                          // ตรวจสอบเงื่อนไข: ถ้า _isFavorited เป็น true ให้แสดงไอคอนหัวใจทึบ สีแดง ถ้าเป็น false แสดงหัวใจโปร่ง
                          _isFavorited ? Icons.favorite : Icons.favorite_border,
                          color: Colors.red,
                          size: 30,
                        ),
                        onPressed: _toggleFavorite, // ผูกฟังก์ชัน _toggleFavorite เข้ากับปุ่ม เมื่อผู้ใช้กดจะเรียกใช้ทันที
                      ),
                      
                      // แสดงตัวเลขจำนวนไลก์แบบ Dynamic ที่อัปเดตตามตัวแปร _favoriteCount
                      Text(
                        '$_favoriteCount',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Divider(color: Colors.grey),
                  const SizedBox(height: 15),
                  
                  // ส่วนปุ่มเมนูด้านล่าง (Button Section: โทร, เส้นทาง, แชร์)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildButtonColumn(Icons.call, 'โทรติดต่อ'),
                      _buildButtonColumn(Icons.near_me, 'เส้นทาง'),
                      _buildButtonColumn(Icons.share, 'แชร์'),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Divider(color: Colors.grey),
                  const SizedBox(height: 15),

                  // ส่วนเนื้อหาบรรยายรายละเอียดสถานที่
                  const Text(
                    'อุทยานแห่งชาติน้ำตกพลิ้ว เป็นแหล่งท่องเที่ยวธรรมชาติที่มีชื่อเสียงของจังหวัดจันทบุรี มีน้ำใสไหลเย็นตลอดปี มีฝูงปลาพลวงพฤกษ์จำนวนมากอาศัยอยู่ เหมาะสำหรับการพักผ่อนหย่อนใจและศึกษาธรรมชาติเชิงนิเวศ',
                    style: TextStyle(fontSize: 15, height: 1.6, color: Colors.black87),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ฟังก์ชันย่อยสำหรับสร้างปุ่มเมนูด้านล่างให้เป็นระเบียบ
  Column _buildButtonColumn(IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: const Color(0xFF2E7D32)),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Color(0xFF2E7D32),
          ),
        ),
      ],
    );
  }
}