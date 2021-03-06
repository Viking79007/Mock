#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ОбработкаЗаполнения(ДанныеЗаполнения, ТекстЗаполнения, СтандартнаяОбработка)

	Если ТипЗнч(ДанныеЗаполнения) = Тип("Структура") Тогда
		
		ЗаполнитьЗначенияСвойств(ЭтотОбъект, ДанныеЗаполнения);
		
		ЭмуляцияMagDelivery.ЗаполнитьЗначенияОбъектаИзВложенныхДанныхЗапроса(ЭтотОбъект, ДанныеЗаполнения, "recipient");
		ЭмуляцияMagDelivery.ЗаполнитьЗначенияОбъектаИзВложенныхДанныхЗапроса(ЭтотОбъект, ДанныеЗаполнения, "slot_param");
		ЭмуляцияMagDelivery.ЗаполнитьЗначенияОбъектаИзВложенныхДанныхЗапроса(ЭтотОбъект, ДанныеЗаполнения, "sizes");
		
		order_number = ДанныеЗаполнения.number;
		
		Дата	= ТекущаяДатаСеанса();
		Номер	= "";
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли