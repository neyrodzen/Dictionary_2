
import 'package:flutter/material.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({Key? key}) : super(key: key);

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}


class _QuestionPageState extends State<QuestionPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Text(''),
            )
          ],
          title: const Center(
            child: Text(
              'Настройка уведомлений',
            ),
          )),
      body: ConstrainedBox(
        constraints: const BoxConstraints(
          minHeight: double.infinity,
          minWidth: double.infinity,
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.white
                : Theme.of(context).scaffoldBackgroundColor,
          ),
          child: const Align(
            alignment: Alignment.topLeft,
            child: SingleChildScrollView(
              child: Column(
                children: [
                 
                
                
                  SizedBox(
                    height: 30,
                  ),
                  Row(children: [
                    SizedBox(
                    width: 15,
                  ),
                  Expanded(child: Text('Для получения уведомлений зайдите в настройки телефона - "Все приложения" - "Английский в уведомлениях"',
                  style: TextStyle(fontSize: 18,height: 1.3),),
                  ),
                   SizedBox(
                    width: 15,
                  ),
                  ],),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    color: Color.fromARGB(255, 35, 35, 35),
                    thickness: 1,
                    indent: 10,
                    endIndent: 10,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                 Row(children: [
                    SizedBox(
                    width: 15,
                  ),
                  Expanded(child: Text('Во вкладке "Разрешения" включите "Отображение на экране блокировки" и "Отображение всплывающих окон"',
                  style: TextStyle(fontSize: 18,height: 1.3),),
                  ),
                   SizedBox(
                    width: 15,
                  ),
                  ],),

                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    color: Color.fromARGB(255, 35, 35, 35),
                    thickness: 1,
                    indent: 10,
                    endIndent: 10,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                   Row(children: [
                    SizedBox(
                    width: 15,
                  ),
                  Expanded(child: Text('Во вкладке "Уведомления" включите все галочки и проверьте пункт "Basic Notifications". Здесь тоже нужно включить все галочки',
                  style: TextStyle(fontSize: 18,height: 1.3),),
                  ),
                   SizedBox(
                    width: 15,
                  ),
                  ],),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    color: Color.fromARGB(255, 35, 35, 35),
                    thickness: 1,
                    indent: 10,
                    endIndent: 10,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(children: [
                    SizedBox(
                    width: 15,
                  ),
                  Expanded(child: Text('Во вкладке "Контроль активности" включите режим "Нет ограничений"',
                  style: TextStyle(fontSize: 18,height: 1.3),),
                  ),
                   SizedBox(
                    width: 15,
                  ),
                  
                  ],),
                  SizedBox(
                    height: 10,
                  ),
                   Divider(
                    color: Color.fromARGB(255, 35, 35, 35),
                    thickness: 1,
                    indent: 10,
                    endIndent: 10,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(children: [
                    SizedBox(
                    width: 15,
                  ),
                  Expanded(child: Text('В "Поиске" или в "Словаре" найдите слова и добавьте их в "Избранное"',
                  style: TextStyle(fontSize: 18,height: 1.3),),
                  ),
                   SizedBox(
                    width: 15,
                  ),
                  ],),
                  SizedBox(
                    height: 10,
                  ),
                   Divider(
                    color: Color.fromARGB(255, 35, 35, 35),
                    thickness: 1,
                    indent: 10,
                    endIndent: 10,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(children: [
                    SizedBox(
                    width: 15,
                  ),
                  Expanded(child: Text('На странице "Настройки" укажите периодичность отправки уведомлений от 1 минуты. Нажмите "ОК"',
                  style: TextStyle(fontSize: 18,height: 1.3),),
                  ),
                   SizedBox(
                    width: 15,
                  ),
                  ],),
                  SizedBox(
                    height: 10,
                  ),
                   Divider(
                    color: Color.fromARGB(255, 35, 35, 35),
                    thickness: 1,
                    indent: 10,
                    endIndent: 10,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(children: [
                    SizedBox(
                    width: 15,
                  ),
                  Expanded(child: Text('Сверните приложение, но не закрывайте',
                  style: TextStyle(fontSize: 18,height: 1.3),),
                  ),
                   SizedBox(
                    width: 15,
                  ),
                  ],),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
