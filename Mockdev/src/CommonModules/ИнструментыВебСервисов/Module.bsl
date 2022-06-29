#Область ПрограммныйИнтерфейс

Функция ПрочитатьСтрокуJSON(СтрокаJSON) Экспорт
	
	Результат = Неопределено;
	
	Попытка
		ЧтениеJSON = Новый ЧтениеJSON;
		ЧтениеJSON.УстановитьСтроку(СтрокаJSON);
		Результат = ПрочитатьJSON(ЧтениеJSON);
	Исключение
		Ошибка = ОписаниеОшибки();
		Возврат Неопределено;
	КонецПопытки;
	
	Возврат Результат;
	
КонецФункции

Функция ТекстJSON(Сообщение) Экспорт
	
	ЗаписьJSON = Новый ЗаписьJSON;
	ЗаписьJSON.УстановитьСтроку();
	
	ЗаписатьJSON(ЗаписьJSON, Сообщение);
	
	Возврат ЗаписьJSON.Закрыть();
	
КонецФункции 

Функция ЗаписатьСтрокуJSON(Данные, ФормироватьСПереносами = Ложь) Экспорт
	
	ЗаписьJSON = Новый ЗаписьJSON;
	Если ФормироватьСПереносами Тогда
		ЗаписьJSON.УстановитьСтроку(Новый ПараметрыЗаписиJSON(, Символы.Таб));
	Иначе
		ЗаписьJSON.УстановитьСтроку(Новый ПараметрыЗаписиJSON(ПереносСтрокJSON.Нет, Символы.Таб));
	КонецЕсли; 
	
	НастройкиСериализацииJSON = Новый НастройкиСериализацииJSON;
	НастройкиСериализацииJSON.ВариантЗаписиДаты = ВариантЗаписиДатыJSON.ЛокальнаяДатаСоСмещением;
	НастройкиСериализацииJSON.ФорматСериализацииДаты = ФорматДатыJSON.ISO;
	
	ЗаписатьJSON(ЗаписьJSON, Данные, НастройкиСериализацииJSON);
	
	Возврат ЗаписьJSON.Закрыть();
	
КонецФункции	

Функция СтрокаBase64БезBOM(СтрокаДанных) Экспорт

	ПотокВПамяти = Новый ПотокВПамяти();
	Текст = Новый ЗаписьТекста(ПотокВПамяти, КодировкаТекста.UTF8, , Символы.ПС);
	Текст.Записать(СтрокаДанных);
	Текст.Закрыть();
	ДвоичныеДанные = ПотокВПамяти.ЗакрытьИПолучитьДвоичныеДанные();
	СтрокаФорматBase64 = Base64Строка(ДвоичныеДанные);
	
	СтрокаФорматBase64 = СтрЗаменить(СтрокаФорматBase64, Символы.ВК, "");
	СтрокаФорматBase64 = СтрЗаменить(СтрокаФорматBase64, Символы.ПС, "");
	
	Возврат СтрокаФорматBase64;

КонецФункции

Функция ДанныеЗапроса(ТипЗапроса = "", АдресЗапроса = "") Экспорт
	
	Результат = Новый Структура;
	Результат.Вставить("ТипЗапроса"  , ТипЗапроса);
	Результат.Вставить("АдресЗапроса", АдресЗапроса);
	Результат.Вставить("ТелоЗапроса" , "");
	Результат.Вставить("Заголовки"   , Новый Соответствие);
	
	Возврат Результат;
	
КонецФункции

Функция ОтправитьHTTPЗапрос(ПараметрыПодключения, ПараметрыЗапроса) Экспорт
	
	ВозвращаемоеЗначение = Новый Структура;
	ВозвращаемоеЗначение.Вставить("КодСостояния");
	ВозвращаемоеЗначение.Вставить("Заголовки");
	ВозвращаемоеЗначение.Вставить("ТекстОтвета");
	ВозвращаемоеЗначение.Вставить("ТекстОшибки");
	
	HTTPЗапрос = Новый HTTPЗапрос(ПараметрыЗапроса.АдресЗапроса, ПараметрыЗапроса.Заголовки);
	
	ЭтоДвоичныеДанные = ТипЗнч(ПараметрыЗапроса.ТелоЗапроса) = Тип("ДвоичныеДанные");
	ЭтоФайл = ТипЗнч(ПараметрыЗапроса.ТелоЗапроса) = Тип("Файл");
	
	Если ПараметрыЗапроса.ТелоЗапроса <> Неопределено Тогда
		Если ЭтоДвоичныеДанные Тогда
			HTTPЗапрос.УстановитьТелоИзДвоичныхДанных(ПараметрыЗапроса.ТелоЗапроса);
		ИначеЕсли ЭтоФайл Тогда
			HTTPЗапрос.УстановитьИмяФайлаТела(ПараметрыЗапроса.ТелоЗапроса.ПолноеИмя);
		Иначе
			HTTPЗапрос.УстановитьТелоИзСтроки(ПараметрыЗапроса.ТелоЗапроса, КодировкаТекста.UTF8, ИспользованиеByteOrderMark.НеИспользовать);
		КонецЕсли;
	КонецЕсли;
		
	HTTPОтвет   = Неопределено;
	ТекстОшибки = "";
	
	//Попытка
		
		Соединение = Новый HTTPСоединение(
			ПараметрыПодключения.Адрес,
			ПараметрыПодключения.Порт, , , ,
			ПараметрыПодключения.Таймаут);
		
		Если ПараметрыЗапроса.ТипЗапроса = "GET" Тогда
			HTTPОтвет = Соединение.Получить(HTTPЗапрос);
		ИначеЕсли ПараметрыЗапроса.ТипЗапроса = "POST" Тогда
			HTTPОтвет = Соединение.ОтправитьДляОбработки(HTTPЗапрос);
		ИначеЕсли ПараметрыЗапроса.ТипЗапроса = "DELETE" Тогда
			HTTPОтвет = Соединение.Удалить(HTTPЗапрос);
		КонецЕсли;
		
	//Исключение
		
		//ТекстОшибки = КраткоеПредставлениеОшибки(ОписаниеОшибки());
		//ЗаписьЖурналаРегистрации(
		//	СобытиеЖурналаРегистрации(),
		//	УровеньЖурналаРегистрации.Ошибка, , ,
		//	СтрШаблон(НСтр("ru = 'Ошибка отправки %1-запроса по адресу %2'"),
		//	ПараметрыЗапроса.ТипЗапроса,
		//	ПараметрыЗапроса.АдресЗапроса) + Символы.ПС + ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
		
	//КонецПопытки;
	
	ВозвращаемоеЗначение.ТекстОшибки = ТекстОшибки;
	Если HTTPОтвет <> Неопределено Тогда
		ВозвращаемоеЗначение.КодСостояния = HTTPОтвет.КодСостояния;
		ВозвращаемоеЗначение.Заголовки = HTTPОтвет.Заголовки;
		ВозвращаемоеЗначение.ТекстОтвета = HTTPОтвет.ПолучитьТелоКакСтроку();
	КонецЕсли;
	
	Возврат ВозвращаемоеЗначение;
	
КонецФункции

#Область КодыОтветов

Функция КодУспешногоОтвета() Экспорт
	
	Возврат 200;
	
КонецФункции

Функция КодОшибкиЗапроса() Экспорт
	
	Возврат 400;
	
КонецФункции

Функция КодОшибкиОбработки() Экспорт
	
	Возврат 500;
	
КонецФункции

#КонецОбласти
		
#КонецОбласти