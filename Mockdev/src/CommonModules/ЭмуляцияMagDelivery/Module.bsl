#Область ПрограммныйИнтерфейс

Функция НастройкиОбмена() Экспорт
	
	НастройкиОбмена = Новый Структура;
	ТекущаяВерсия = Константы.ВерсияAPIMagDelivery.Получить();
	НастройкиОбмена.Вставить("ТекущаяВерсияAPI", ТекущаяВерсия);
	
	Возврат НастройкиОбмена;
	
КонецФункции

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

#Область ВзаимодействиеСВнешнимиСистемами

Функция ОписаниеВерсииАПИ(Запрос) Экспорт
	
	ОписаниеВерсииАПИ = Новый Структура;
	ОписаниеВерсииАПИ.Вставить("ВерсияAPI");
	ОписаниеВерсииАПИ.Вставить("Методы");
	ОписаниеВерсииАПИ.Вставить("ИменаПолейОтвета");
	
	ВерсияAPI = ЭмуляцияMagDelivery.ВерсияAPIПоОтносительномуАдресу(Запрос.ОтносительныйURL);
	ОписаниеВерсииАПИ.ВерсияAPI = ВерсияAPI;
	
	МенеджерВерсий = Перечисления.ВерсииAPIMagDelivery;
	
	Если ВерсияAPI = МенеджерВерсий.Версия1 Тогда
		
		ОписаниеВерсииАПИ.Методы = "warehouse_to_customer,";
		
		ОписаниеПолейОтветов = Новый Структура;
		
		ОписаниеПолейWarehouseToCustomer(ОписаниеПолейОтветов);
		
		ОписаниеВерсииАПИ.ИменаПолейОтвета = ОписаниеПолейОтветов;
		
	КонецЕсли;
	
	Возврат ОписаниеВерсииАПИ;
	
КонецФункции

Функция ПроверкаВерсииAPI(ВерсияAPIЗапроса, ТекущаяВерсияAPI) Экспорт
	
	// Если в адресе нет версии - считаем, что это первая версия
	Если ВерсияAPIЗапроса.Пустая() Тогда
		ВерсияAPIЗапроса = Перечисления.ВерсииAPIMagDelivery.Версия1;
	КонецЕсли;
	
	Возврат ВерсияAPIЗапроса = ТекущаяВерсияAPI;
	
КонецФункции

Функция ВерсияAPIПоОтносительномуАдресу(ОтносительныйАдрес) Экспорт
	
	РазделенныйАдрес = СтрРазделить(ОтносительныйАдрес, "/", Ложь);
	ВерсияСтрокой = РазделенныйАдрес[1];
	
	МенеджерВерсий = Перечисления.ВерсииAPIMagDelivery;
	
	ВерсияAPI = МенеджерВерсий.ПустаяСсылка();
	
	Если ВерсияСтрокой = "v1" Тогда
		ВерсияAPI = МенеджерВерсий.Версия1;
	КонецЕсли;
	
	Возврат ВерсияAPI;
	
КонецФункции

Функция СтроковоеПредставлениеВерсии(Версия) Экспорт
	
	ПредставлениеВерсии = "v1";
	
	Если Версия = Перечисления.ВерсииAPIMagDelivery.Версия1 Тогда
		ПредставлениеВерсии = "v1";
	КонецЕсли;
	
	Возврат ПредставлениеВерсии;
	
КонецФункции

Функция НастройкаПодключенияКБазеТестирования() Экспорт
	
	НастройкиОбмена = Константы.НастройкиОбменаMagDelivery.Получить().Получить();
	
	Настройки = Новый Структура;
	
	Если НастройкиОбмена <> Неопределено Тогда
	
		Если НастройкиОбмена.Свойство("Адрес") Тогда
			Настройки.Вставить("Адрес", НастройкиОбмена.Адрес);
		КонецЕсли;
		
		Если НастройкиОбмена.Свойство("Порт") Тогда
			Настройки.Вставить("Порт", НастройкиОбмена.Порт);
		КонецЕсли;
		
		Если НастройкиОбмена.Свойство("ИмяИнформационнойБазы") Тогда
			Настройки.Вставить("ИмяИнформационнойБазы", НастройкиОбмена.ИмяИнформационнойБазы);
		КонецЕсли;
		
		Если НастройкиОбмена.Свойство("Таймаут") Тогда
			Настройки.Вставить("Таймаут", НастройкиОбмена.Таймаут);
		КонецЕсли;

		Если НастройкиОбмена.Свойство("Логин") Тогда
			Настройки.Вставить("Логин", НастройкиОбмена.Логин);
		КонецЕсли;

		Если НастройкиОбмена.Свойство("Пароль") Тогда
			Настройки.Вставить("Пароль", НастройкиОбмена.Пароль);
		КонецЕсли;
	
	КонецЕсли;
	
	Возврат Настройки;
	
КонецФункции

Функция ИнициализироватьПараметрыПодключенияКБазеТестирования() Экспорт
	
	Параметры = Новый Структура;
	Параметры.Вставить("Адрес", "");
	Параметры.Вставить("Порт", "");
	Параметры.Вставить("ИмяИнформационнойБазы", "");
	Параметры.Вставить("Таймаут", 0);
	Параметры.Вставить("Логин", "");
	Параметры.Вставить("Пароль", "");

	Возврат Параметры;
	
КонецФункции

#КонецОбласти

#Область Заказы

Процедура ИмпортЗаказов(Запрос, Ответ, ТелоОтвета) Экспорт

	Тело = Запрос.ПолучитьТелоКакСтроку();
	Данные = ИнструментыВебСервисов.ПрочитатьСтрокуJSON(Тело);
	
	РезультатВалидации = ПроверитьСоответствиеФормату(Данные);
	КлючОшибки = НСтр("ru='Ошибка обработки сообщения'");
	
	Если Не РезультатВалидации.ЕстьОшибки Тогда
		
		РезультатЗаписи = СоздатьДокументыПоВходящимДанным(Данные);
		
		Если РезультатЗаписи.ЕстьОшибки Тогда
			
			Ответ.КодСостояния = ИнструментыВебСервисов.КодОшибкиОбработки();
			
			Для Каждого Ошибка Из РезультатЗаписи.Ошибки Цикл
				ДобавитьОшибкуВТелоОтвета(ТелоОтвета, КлючОшибки, Ошибка);
			КонецЦикла;
			
		КонецЕсли;
		
	Иначе
		
		Ответ.КодСостояния = ИнструментыВебСервисов.КодОшибкиЗапроса();
		
		Для Каждого Ошибка Из РезультатВалидации.Ошибки Цикл
			ДобавитьОшибкуВТелоОтвета(ТелоОтвета, КлючОшибки, Ошибка);
		КонецЦикла;
		
	КонецЕсли;
	
КонецПроцедуры

Процедура ЗаполнитьЗначенияОбъектаИзВложенныхДанныхЗапроса(ЗаполняемыйОбъект, ДанныеЗапроса, ИмяПоляДанных) Экспорт
	
	ВложенныеДанные = Неопределено;
	Если Не ДанныеЗапроса.Свойство(ИмяПоляДанных, ВложенныеДанные) Тогда
		Возврат;
	КонецЕсли;
	
	Если ТипЗнч(ВложенныеДанные) <> Тип("Структура") Тогда
		Возврат;
	КонецЕсли;
	
	ЗаполнитьЗначенияСвойств(ЗаполняемыйОбъект, ВложенныеДанные);
	ЕстьРеквизитДата = (ЗаполняемыйОбъект.Метаданные().Реквизиты.Найти("order_date") <> Неопределено);
	ЕстьРеквизитВремяНачала = (ЗаполняемыйОбъект.Метаданные().Реквизиты.Найти("time_start") <> Неопределено);
	ЕстьРеквизитВремяОкончания = (ЗаполняемыйОбъект.Метаданные().Реквизиты.Найти("time_end") <> Неопределено);
	
	Для Каждого ЭлементДанных Из ВложенныеДанные Цикл
		
		Если ТипЗнч(ЭлементДанных.Значение) = Тип("Структура") Тогда
			
			ЗаполнитьЗначенияОбъектаИзВложенныхДанныхЗапроса(ЗаполняемыйОбъект, ВложенныеДанные, ЭлементДанных.Ключ);
			
		ИначеЕсли ЭлементДанных.Ключ = "date" И ЕстьРеквизитДата Тогда
			
			ЗаполняемыйОбъект.order_date = Дата(СтрЗаменить(ЭлементДанных.Значение, "-", ""));
			
		ИначеЕсли ЭлементДанных.Ключ = "time_start" И ЕстьРеквизитВремяНачала Тогда
			
			ЗаполняемыйОбъект.time_start = Дата("00010101" + СтрЗаменить(ЭлементДанных.Значение, ":", "") + "00");
			
		ИначеЕсли ЭлементДанных.Ключ = "time_end" И ЕстьРеквизитВремяОкончания Тогда
			
			ЗаполняемыйОбъект.time_end = Дата("00010101" + СтрЗаменить(ЭлементДанных.Значение, ":", "") + "00");
			
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти

#Область Рейсы

Процедура ОтправитьРейсВТестируемуюБазу(Рейс) Экспорт
	
	// TODO: вытащить данные запросом
	
	ИнформацияОЗаказах = Новый Массив();
	
	Для Каждого СтрокаЗаказыРейса Из Рейс.Заказы Цикл
		ОтправляемыеДанныеЗаказа = Новый Структура();
		ОтправляемыеДанныеЗаказа.Вставить("guid", СтрокаЗаказыРейса.Заказ.guid);
		ОтправляемыеДанныеЗаказа.Вставить("status", "completed"); // TODO: заполнить;
		ОтправляемыеДанныеЗаказа.Вставить("warehouse_guid", СтрокаЗаказыРейса.Заказ.sender_warehouse_guid);
		
		ОтправляемыеДанныеРейса = Новый Структура();
		ОтправляемыеДанныеРейса.Вставить("courier_guid", Строка(Рейс.Водитель.УникальныйИдентификатор()));
		ОтправляемыеДанныеРейса.Вставить("transport_guid", Строка(Рейс.ТранспортноеСредство.УникальныйИдентификатор()));
		//ОтправляемыеДанныеРейса.Вставить("session_guid",);
		ОтправляемыеДанныеРейса.Вставить("route_guid", Строка(Рейс.УникальныйИдентификатор()));
		ОтправляемыеДанныеРейса.Вставить("route_date_time_planned_start", Рейс.ДатаНачала);
		ОтправляемыеДанныеРейса.Вставить("route_date_time_planned_finish", Рейс.ДатаОкончания);
		
		ОтправляемыеДанныеЗаказа.Вставить("delivery_param", ОтправляемыеДанныеРейса);
		
		ИнформацияОЗаказах.Добавить(ОтправляемыеДанныеЗаказа);
		
	КонецЦикла;
	
	ПараметрыПодключения = НастройкаПодключенияКБазеТестирования();
	
	ПараметрыЗапроса = ИнструментыВебСервисов.ДанныеЗапроса("POST", "/" + ПараметрыПодключения.ИмяИнформационнойБазы + "/hs/MagDelivery/v1/UpdateOrder/");
	ПараметрыЗапроса.ТелоЗапроса = ИнструментыВебСервисов.ТекстJSON(ИнформацияОЗаказах);
	
	Хеш = ИнструментыВебСервисов.СтрокаBase64БезBOM(ПараметрыПодключения.Логин + ":" + ПараметрыПодключения.Пароль);
	Заголовки = Новый Соответствие();
	Заголовки.Вставить("Authorization", "Basic " + Хеш);
	
	ПараметрыЗапроса.Заголовки = Заголовки;
	
	РезультатЗапроса = ИнструментыВебСервисов.ОтправитьHTTPЗапрос(ПараметрыПодключения, ПараметрыЗапроса);
	
	Если РезультатЗапроса.КодСостояния = 200 Тогда
		ТекстСообщенияПользователю = НСтр("ru = 'Рейс успешно отправлен!'");
	Иначе
		ШаблонСообщения = НСтр("ru = 'Ошибка отправки заказов.
			|%1'");
		ТекстСообщенияПользователю = СтрШаблон(ШаблонСообщения, РезультатЗапроса.ТекстОтвета);	
	КонецЕсли;
	
	//TODO: нужен метод из БСП
	Сообщение = Новый СообщениеПользователю;
	Сообщение.Текст = ТекстСообщенияПользователю;
	Сообщение.Сообщить();
	
КонецПроцедуры

#КонецОбласти
	
#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область Заказы

Функция СоздатьДокументыПоВходящимДанным(Данные)
	
	РезультатЗаписиЗаказа = Новый Структура;
	РезультатЗаписиЗаказа.Вставить("ЕстьОшибки", Ложь);
	РезультатЗаписиЗаказа.Вставить("Ошибки", Новый Массив);
	
	Для Каждого Элемент Из Данные Цикл
		
		ЗаказОбъект = Документы.ЗаказКлиента.СоздатьДокумент();
		ЗаказОбъект.Заполнить(Элемент);
		
		Попытка
			
			ЗаказОбъект.Записать(РежимЗаписиДокумента.Проведение);
			
		Исключение
			
			ШаблонСообщения = "Не удалось обработать входящее сообщение. Причина: %1";
			ПредставлениеОшибки = ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
			ТекстСообщения = СтрШаблон(ШаблонСообщения, ПредставлениеОшибки);
			
			РезультатЗаписиЗаказа.ЕстьОшибки = Истина;
			РезультатЗаписиЗаказа.Ошибки.Добавить(ТекстСообщения);
			
		КонецПопытки
		
	КонецЦикла;
	
	Возврат РезультатЗаписиЗаказа;
	
КонецФункции

#Область ВалидацияДанных

Функция ПроверитьСоответствиеФормату(Данные)
	
	РезультатВалидации = Новый Структура;
	РезультатВалидации.Вставить("Ошибки", Новый Массив);
	РезультатВалидации.Вставить("ЕстьОшибки", Ложь);
	
	ПараметрыПолей = ПараметрыПроверяемыхПолей();
	ПараметрыДополнительныхПолей = ПараметрыДополнительныхПроверяемыхПолей();
	
	Для Каждого ЭлементДанных Из Данные Цикл
		
		ПроверитьСоответствиеДанныхПараметрамПолей(ЭлементДанных,
													РезультатВалидации,
													ПараметрыПолей,
													ПараметрыДополнительныхПолей);
		
	КонецЦикла;
	
	Возврат РезультатВалидации;
	
КонецФункции

Функция ПараметрыПроверяемыхПолей()
	
	ПараметрыПолей = Новый Массив;
	
	ОписаниеТиповСтрока		= Новый ОписаниеТипов("Строка");
	ОписаниеТиповСтрока36	= Новый ОписаниеТипов("Строка", , , , Новый КвалификаторыСтроки(36));
	ОписаниеТиповЧисло15_2	= Новый ОписаниеТипов("Число", , , Новый КвалификаторыЧисла(15, 2, ДопустимыйЗнак.Неотрицательный));
	ОписаниеТиповСтруктура	= Новый ОписаниеТипов("Структура");
	ОписаниеТиповМассив		= Новый ОписаниеТипов("Массив");
	
	ДобавитьПроверяемоеПоле(ПараметрыПолей, "guid", ОписаниеТиповСтрока36, Истина);
	ДобавитьПроверяемоеПоле(ПараметрыПолей, "number", ОписаниеТиповСтрока, Истина);
	ДобавитьПроверяемоеПоле(ПараметрыПолей, "recipient", ОписаниеТиповСтруктура, Истина);
	ДобавитьПроверяемоеПоле(ПараметрыПолей, "slot_param", ОписаниеТиповСтруктура, Истина);
	ДобавитьПроверяемоеПоле(ПараметрыПолей, "sizes", ОписаниеТиповСтруктура, Истина);
	ДобавитьПроверяемоеПоле(ПараметрыПолей, "sender_warehouse_guid", ОписаниеТиповСтрока, Истина);
	ДобавитьПроверяемоеПоле(ПараметрыПолей, "ext_doc_number_list", ОписаниеТиповМассив, Ложь);
	ДобавитьПроверяемоеПоле(ПараметрыПолей, "amount_without_tax", ОписаниеТиповЧисло15_2, Истина);
	
	Возврат ПараметрыПолей;
	
КонецФункции

Функция ПараметрыДополнительныхПроверяемыхПолей()
	
	ПараметрыПолей = Новый Структура;
	
	ПараметрыПолей.Вставить("recipient", ПараметрыПроверяемыхПолейКонтакт());
	ПараметрыПолей.Вставить("slot_param", ПараметрыПроверяемыхПолейСлотДоставки());
	ПараметрыПолей.Вставить("sizes", ПараметрыПроверяемыхПолейРазмеры());
	ПараметрыПолей.Вставить("recipient_point", ПараметрыПроверяемыхПолейКоординатнаяТочка());
	ПараметрыПолей.Вставить("recipient_company", ПараметрыПроверяемыхПолейКомпания());
	
	
	Возврат ПараметрыПолей;
	
КонецФункции

Процедура ПроверитьСоответствиеДанныхПараметрамПолей(Данные,
														РезультатВалидации,
														ПараметрыПолей,
														ПараметрыДополнительныхПолей,
														СтрокаРодительскихПолей = "")
	
	Для Каждого ПараметрыПоля Из ПараметрыПолей Цикл
		
		ПолноеИмяПоля = СтрокаРодительскихПолей + ПараметрыПоля.ИмяПоля;
		
		ЗначениеПоля = Неопределено;
		ПолеНайдено = Данные.Свойство(ПараметрыПоля.ИмяПоля, ЗначениеПоля);
		Если Не ПолеНайдено Тогда
			
			ДобавитьОшибкуНаличияАтрибутаПриНеобходимости(РезультатВалидации, ПолноеИмяПоля, ПараметрыПоля.ОбязательноеЗаполнение);
			Продолжить;
			
		КонецЕсли;
		
		Если Не ПараметрыПоля.ТипПоля.СодержитТип(ТипЗнч(ЗначениеПоля)) Тогда
			
			ДобавитьОшибкуНекорректногоТипа(РезультатВалидации, ПолноеИмяПоля);
			Продолжить;
			
		КонецЕсли;
		
		ПроверитьФорматЗначенияПоля(ЗначениеПоля, ПолноеИмяПоля, РезультатВалидации);
		
		Если ТипЗнч(ЗначениеПоля) = Тип("Структура") Тогда
			
			ПараметрыВложенныхПолей = Неопределено;
			КлючПараметровПоПолномуИмени = СтрЗаменить(ПолноеИмяПоля, ".", "_");
			Если ПараметрыДополнительныхПолей.Свойство(КлючПараметровПоПолномуИмени, ПараметрыВложенныхПолей) Тогда
				
				ПутьКВложеннымПолям = ПолноеИмяПоля + ".";
				ПроверитьСоответствиеДанныхПараметрамПолей(ЗначениеПоля,
															РезультатВалидации,
															ПараметрыВложенныхПолей,
															ПараметрыДополнительныхПолей,
															ПутьКВложеннымПолям);
				
			КонецЕсли;
			
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

Процедура ПроверитьФорматЗначенияПоля(ЗначениеПоля, ПолноеИмяПоля, РезультатВалидации)
	
	Если СтрЗаканчиваетсяНа(ПолноеИмяПоля, "number")
		Или СтрЗаканчиваетсяНа(ПолноеИмяПоля, "address")
		Или СтрЗаканчиваетсяНа(ПолноеИмяПоля, "name")
		Или СтрЗаканчиваетсяНа(ПолноеИмяПоля, "volume")
		Или СтрЗаканчиваетсяНа(ПолноеИмяПоля, "weight") Тогда
		
		Если Не ЗначениеЗаполнено(ЗначениеПоля) Тогда
			ДобавитьОшибкуНезаполненногоЗначения(РезультатВалидации, ПолноеИмяПоля);
		КонецЕсли;
		
	КонецЕсли;
	
	Если СтрЗаканчиваетсяНа(ПолноеИмяПоля, "phone") Тогда
		
		Если Не НомерТелефонаЗаполнен(ЗначениеПоля) Тогда
			ДобавитьОшибкуНезаполненногоЗначения(РезультатВалидации, ПолноеИмяПоля);
		КонецЕсли;
		
	КонецЕсли;
	
	Если СтрЗаканчиваетсяНа(ПолноеИмяПоля, "guid") Тогда
		
		Если Не СтроковыеФункцииКлиентСервер.ЭтоУникальныйИдентификатор(ЗначениеПоля) Тогда
			ДобавитьОшибкуНесоответствияФормату(РезультатВалидации, ПолноеИмяПоля);
		КонецЕсли;
		
	КонецЕсли;
	
	Если СтрЗаканчиваетсяНа(ПолноеИмяПоля, "date") Тогда
		
		Если Не СтрокаСодержитДату(ЗначениеПоля) Тогда
			ДобавитьОшибкуНесоответствияФормату(РезультатВалидации, ПолноеИмяПоля);
		КонецЕсли;
		
	КонецЕсли;
	
	Если СтрЗаканчиваетсяНа(ПолноеИмяПоля, "time_start")
		Или СтрЗаканчиваетсяНа(ПолноеИмяПоля, "time_end") Тогда
		
		Если Не СтрокаСодержитВремя(ЗначениеПоля) Тогда
			ДобавитьОшибкуНесоответствияФормату(РезультатВалидации, ПолноеИмяПоля);
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

Функция ПараметрыПроверяемыхПолейКонтакт()
	
	ПараметрыПолей = Новый Массив;
	
	ОписаниеТиповСтрока		= Новый ОписаниеТипов("Строка");
	ОписаниеТиповСтрока12	= Новый ОписаниеТипов("Строка", , , , Новый КвалификаторыСтроки(12));
	ОписаниеТиповСтруктура	= Новый ОписаниеТипов("Структура");
	
	ДобавитьПроверяемоеПоле(ПараметрыПолей, "address", ОписаниеТиповСтрока, Истина);
	ДобавитьПроверяемоеПоле(ПараметрыПолей, "point", ОписаниеТиповСтруктура, Ложь);
	ДобавитьПроверяемоеПоле(ПараметрыПолей, "name", ОписаниеТиповСтрока, Истина);
	ДобавитьПроверяемоеПоле(ПараметрыПолей, "phone", ОписаниеТиповСтрока12, Истина);
	ДобавитьПроверяемоеПоле(ПараметрыПолей, "comment", ОписаниеТиповСтрока, Ложь);
	ДобавитьПроверяемоеПоле(ПараметрыПолей, "company", ОписаниеТиповСтруктура, Ложь);
	
	Возврат ПараметрыПолей;
	
КонецФункции

Функция ПараметрыПроверяемыхПолейКомпания()
	
	ПараметрыПолей = Новый Массив;
	
	ОписаниеТиповСтрока		= Новый ОписаниеТипов("Строка");
	
	ДобавитьПроверяемоеПоле(ПараметрыПолей, "short_name", ОписаниеТиповСтрока, Истина);
	
	Возврат ПараметрыПолей;
	
КонецФункции

Функция ПараметрыПроверяемыхПолейКоординатнаяТочка()
	
	ПараметрыПолей = Новый Массив;
	
	ОписаниеТиповЧисло15_2	= Новый ОписаниеТипов("Число", , , Новый КвалификаторыЧисла(15, 2));
	
	ДобавитьПроверяемоеПоле(ПараметрыПолей, "lat", ОписаниеТиповЧисло15_2, Истина);
	ДобавитьПроверяемоеПоле(ПараметрыПолей, "lon", ОписаниеТиповЧисло15_2, Истина);
	
	Возврат ПараметрыПолей;
	
КонецФункции

Функция ПараметрыПроверяемыхПолейСлотДоставки()
	
	ПараметрыПолей = Новый Массив;
	
	ОписаниеТиповСтрока36	= Новый ОписаниеТипов("Строка", , , , Новый КвалификаторыСтроки(36));
	ОписаниеТиповСтрока10	= Новый ОписаниеТипов("Строка", , , , Новый КвалификаторыСтроки(10, ДопустимаяДлина.Фиксированная));
	ОписаниеТиповСтрока5	= Новый ОписаниеТипов("Строка", , , , Новый КвалификаторыСтроки(5));

	ДобавитьПроверяемоеПоле(ПараметрыПолей, "date", ОписаниеТиповСтрока10, Истина);
	ДобавитьПроверяемоеПоле(ПараметрыПолей, "time_start", ОписаниеТиповСтрока5, Истина);
	ДобавитьПроверяемоеПоле(ПараметрыПолей, "time_end", ОписаниеТиповСтрока5, Истина);
	ДобавитьПроверяемоеПоле(ПараметрыПолей, "delivery_method_guid", ОписаниеТиповСтрока36, Истина);
	
	Возврат ПараметрыПолей;
	
КонецФункции

Функция ПараметрыПроверяемыхПолейРазмеры()
	
	ПараметрыПолей = Новый Массив;
	
	ОписаниеТиповЧисло15_2	= Новый ОписаниеТипов("Число", , , Новый КвалификаторыЧисла(15, 2));
	
	ДобавитьПроверяемоеПоле(ПараметрыПолей, "length", ОписаниеТиповЧисло15_2, Ложь);
	ДобавитьПроверяемоеПоле(ПараметрыПолей, "width", ОписаниеТиповЧисло15_2, Ложь);
	ДобавитьПроверяемоеПоле(ПараметрыПолей, "height", ОписаниеТиповЧисло15_2, Ложь);
	ДобавитьПроверяемоеПоле(ПараметрыПолей, "volume", ОписаниеТиповЧисло15_2, Истина);
	ДобавитьПроверяемоеПоле(ПараметрыПолей, "weight", ОписаниеТиповЧисло15_2, Истина);
	
	Возврат ПараметрыПолей;
	
КонецФункции

Процедура ДобавитьПроверяемоеПоле(ПараметрыПолей, ИмяПоля, ТипПоля, ОбязательноеЗаполнение)
	
	ПолеСтроки = ОписаниеСтруктурыПоля();
	ПолеСтроки.ИмяПоля = ИмяПоля;
	ПолеСтроки.ТипПоля = ТипПоля;
	ПолеСтроки.ОбязательноеЗаполнение = ОбязательноеЗаполнение;
	ПараметрыПолей.Добавить(ПолеСтроки);
	
КонецПроцедуры

Процедура ДобавитьОшибкуНаличияАтрибутаПриНеобходимости(РезультатВалидации, ПолноеИмяПоля, ОбязательноеЗаполнение)
	
	Если Не ОбязательноеЗаполнение Тогда
		Возврат;
	КонецЕсли;
	
	ШаблонСообщения = Нстр("ru = 'Отсутствует %1артибут %2'");
	ОбязательноеПолеПредставление = ?(ОбязательноеЗаполнение, "обязательный ", "");
	ТекстСообщения = СтрШаблон(ШаблонСообщения, ОбязательноеПолеПредставление, ПолноеИмяПоля);
	
	ДанныеОшибки = ДанныеОшибки(ПолноеИмяПоля, ТекстСообщения);
	РезультатВалидации.Ошибки.Добавить(ДанныеОшибки);
	РезультатВалидации.ЕстьОшибки = Истина;
	
КонецПроцедуры

Процедура ДобавитьОшибкуНекорректногоТипа(РезультатВалидации, ПолноеИмяПоля)
	
	ШаблонСообщения = Нстр("ru = 'Тип значения артибута %1 не соответствует формату'");
	ТекстСообщения = СтрШаблон(ШаблонСообщения, ПолноеИмяПоля);
	
	ДанныеОшибки = ДанныеОшибки(ПолноеИмяПоля, ТекстСообщения);
	РезультатВалидации.Ошибки.Добавить(ДанныеОшибки);
	РезультатВалидации.ЕстьОшибки = Истина;
	
КонецПроцедуры

Процедура ДобавитьОшибкуНесоответствияФормату(РезультатВалидации, ПолноеИмяПоля)
	
	ШаблонСообщения = Нстр("ru = 'Содержимое артибута %1 не соответствует формату'");
	ТекстСообщения = СтрШаблон(ШаблонСообщения, ПолноеИмяПоля);
	
	ДанныеОшибки = ДанныеОшибки(ПолноеИмяПоля, ТекстСообщения);
	РезультатВалидации.Ошибки.Добавить(ДанныеОшибки);
	РезультатВалидации.ЕстьОшибки = Истина;
	
КонецПроцедуры

Процедура ДобавитьОшибкуНезаполненногоЗначения(РезультатВалидации, ПолноеИмяПоля)
	
	ШаблонСообщения = Нстр("ru = 'Значение артибута %1 не заполнено'");
	ТекстСообщения = СтрШаблон(ШаблонСообщения, ПолноеИмяПоля);
	
	ДанныеОшибки = ДанныеОшибки(ПолноеИмяПоля, ТекстСообщения);
	РезультатВалидации.Ошибки.Добавить(ДанныеОшибки);
	РезультатВалидации.ЕстьОшибки = Истина;
	
КонецПроцедуры

Функция ОписаниеСтруктурыПоля()
	
	СтруктураПоля = Новый Структура("ИмяПоля, ТипПоля, ОбязательноеЗаполнение");
	
	Возврат СтруктураПоля;
	
КонецФункции

Функция СтрокаСодержитДату(Строка)
	
	ЧастиСтроки = СтрРазделить(Строка, "-");
	Если ЧастиСтроки.Количество() <> 3 Тогда
		Возврат Ложь;
	КонецЕсли;
	
	СтрокаГода = ЧастиСтроки[0];
	ГодСоответствуетФормату = 
		(СтроковыеФункцииКлиентСервер.ТолькоЦифрыВСтроке(СтрокаГода)
			И СтрДлина(СтрокаГода) = 4);
	СтрокаМесяца = ЧастиСтроки[1];
	МесяцСоответствуетФормату =
		(СтроковыеФункцииКлиентСервер.ТолькоЦифрыВСтроке(СтрокаМесяца)
			И СтрДлина(СтрокаМесяца) = 2);
	СтрокаДня = ЧастиСтроки[2];
	ДеньСоответствуетФормату = 
		(СтроковыеФункцииКлиентСервер.ТолькоЦифрыВСтроке(СтрокаДня)
			И СтрДлина(СтрокаДня) = 2);
	
	Возврат (ГодСоответствуетФормату
		И МесяцСоответствуетФормату
		И ДеньСоответствуетФормату);
	
КонецФункции

Функция СтрокаСодержитВремя(Строка)
	
	ЧастиСтроки = СтрРазделить(Строка, ":");
	Если ЧастиСтроки.Количество() <> 2 Тогда
		Возврат Ложь;
	КонецЕсли;
	
	СтрокаЧаса = ЧастиСтроки[0];
	ЧасСоответствуетФормату = 
		(СтроковыеФункцииКлиентСервер.ТолькоЦифрыВСтроке(СтрокаЧаса)
			И СтрДлина(СтрокаЧаса) = 2);
	СтрокаМинут = ЧастиСтроки[1];
	МинутыСоответствуютФормату = 
		(СтроковыеФункцииКлиентСервер.ТолькоЦифрыВСтроке(СтрокаМинут)
			И СтрДлина(СтрокаМинут) = 2);
	
	Возврат (ЧасСоответствуетФормату
		И МинутыСоответствуютФормату);
	
КонецФункции

Функция НомерТелефонаЗаполнен(Строка)

	ВариантыПустыхНомеров = Новый Массив;
	ВариантыПустыхНомеров.Добавить("");
	ВариантыПустыхНомеров.Добавить("+70000000000");
	ВариантыПустыхНомеров.Добавить("80000000000");

	Возврат ВариантыПустыхНомеров.Найти(Строка) = Неопределено;

КонецФункции

#КонецОбласти

#КонецОбласти

Функция СобытиеЖурналаРегистрации()
	Возврат НСтр("ru = 'Интеграция с Mag Delivery'", ОбщегоНазначения.КодОсновногоЯзыка());
КонецФункции

Процедура ОписаниеПолейWarehouseToCustomer(ОписаниеПолейОтветов)
	
	ПоляОтвета = ПоляОтветаОбщие();
	ОписаниеПолейОтветов.Вставить("warehouse_to_customer", ПоляОтвета);
	
КонецПроцедуры

Функция ПоляОтветаОбщие()
	
	ПоляОтвета = Новый Структура;
	ПоляОтвета.Вставить("data",			Неопределено);
	ПоляОтвета.Вставить("errors", 		Неопределено);
	ПоляОтвета.Вставить("pagination", 	Неопределено);
	
	Возврат ПоляОтвета;
	
КонецФункции

Процедура ДобавитьОшибкуВТелоОтвета(ТелоОтвета, КлючОшибки, ТекстОшибки)
	
	Ошибка = ДанныеОшибки(КлючОшибки, ТекстОшибки);
	ТелоОтвета.errors.Добавить(Ошибка);
	
КонецПроцедуры

Функция ДанныеОшибки(КлючОшибки, ТекстОшибки)
	
	Данные = Новый Структура;
	Данные.Вставить("key", КлючОшибки);
	Данные.Вставить("error", ТекстОшибки);
	
	Возврат Данные;
	
КонецФункции

#КонецОбласти