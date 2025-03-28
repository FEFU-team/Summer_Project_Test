type
  ptrNode = ^Node;
  Node = record
    data: integer;
    next: ptrNode;
  end;

var
  p_begin: ptrNode;     
  choice, n: integer;  

procedure CreateList(var p_begin: ptrNode; num: integer);
var
  p: ptrNode;
  i: integer;
begin
  if p_begin <> nil then begin
    writeln('Список уже существует.');
    exit;
  end;
  new(p_begin);
  i := 1;
  p_begin^.next := nil;
  p_begin^.data := random(101); 
  p := p_begin;
  while i < num do begin
    new(p^.next);
    p := p^.next;
    p^.next := nil;
    i := i + 1;
    p^.data := random(101); 
  end;
  writeln('Список из ', num, ' элементов создан.');
end;

procedure PrintList(p_begin: ptrNode);
var
  p: ptrNode;
begin
  if p_begin = nil then begin
    writeln('Список пуст!');
    exit;
  end;
  writeln('Список:');
  p := p_begin;
  while p <> nil do begin
    writeln('[', p^.data, ' | ', p, ']');
    p := p^.next;
  end;
end;

procedure RemoveList(var p_begin: ptrNode);
var
  p: ptrNode;
begin
  if p_begin = nil then begin
    writeln('Список пуст!');
    exit;
  end;
  p := p_begin;
  while p^.next <> nil do begin
    p := p^.next;
    dispose(p_begin);
    p_begin := p;
  end;
  dispose(p_begin);
  p_begin := nil;
  writeln('Список удален.');
end;

procedure AddElement(var p_begin: ptrNode; num: integer);
var
  p, h, q: ptrNode;
  i: integer;
  value: integer;  
begin
  if p_begin = nil then begin
    new(p_begin);
    write('Введите значение первого элемента: ');
    readln(value);  
    p_begin^.data := value;  
    p_begin^.next := nil;
    writeln('Список был пуст. Создан первый элемент со значением ', p_begin^.data);
    exit;
  end;
  i := 1;
  p := p_begin;
  if num <= 1 then begin
    writeln('Добавляем элемент на первое место');
    new(q);
    write('Введите значение элемента: ');
    readln(value);  
    q^.data := value;  
    q^.next := p_begin;
    p_begin := q;
    writeln('Элемент со значением ', q^.data, ' добавлен в начало списка.');
    exit;
  end;
  p := p_begin;
  while (i <> num) and (p^.next <> nil) do begin
    h := p;
    p := p^.next;
    i := i + 1;
  end;
  if i = num then begin
    new(q);
    write('Введите значение элемента: ');
    readln(value);  
    q^.data := value;  
    q^.next := p;
    h^.next := q;
    writeln('Элемент со значением ', q^.data, ' добавлен на позицию ', num);
  end else begin
    new(q);
    q^.next := nil;
    write('Введите значение элемента: ');
    readln(value);  
    q^.data := value;  
    p^.next := q;
    writeln('Элемент со значением ', q^.data, ' добавлен в конец списка.');
  end;
end;

procedure DeleteElement(var p_begin: ptrNode; dn: integer);
var
  p, h: ptrNode;
  i: integer;
begin
  if p_begin = nil then begin
    writeln('Список пуст!');
    exit;
  end;
  p := p_begin;
  i := 1;
  if dn < 1 then begin
    writeln('Номер удаляемого элемента < 1. Устанавливаем dn = 1');
    dn := 1;
  end;
  if dn = 1 then begin
    p_begin := p_begin^.next;
    dispose(p);
    writeln('Первый элемент удален.');
    exit;
  end;
  while (i <> dn) and (p^.next <> nil) do begin
    h := p;
    p := p^.next;
    i := i + 1;
  end;
  if (p^.next = nil) and (i <> dn) then begin
    writeln('Выход за границу списка. Удаляем последний элемент.');
    dispose(p);
    h^.next := nil;
  end 
  else 
    begin
    h^.next := p^.next;
    dispose(p);
    writeln('Элемент на позиции ', dn, ' удален.');
  end;
end;


begin
  randomize;  
  p_begin := nil;
  
  repeat
    writeln('   ');
    writeln('Меню операций со списком');
    writeln('1. Создать список');
    writeln('2. Распечатать список');
    writeln('3. Удалить весь список');
    writeln('4. Добавить элемент');
    writeln('5. Удалить элемент');
    writeln('0. Выход');
    write('Выберите операцию: ');
    readln(choice);
    
    case choice of
      1: begin
           write('Введите количество элементов (>2): ');
           readln(n);
           if n > 2 then
             CreateList(p_begin, n)
           else
             writeln('Количество элементов должно быть больше 2.');
         end;
      2: PrintList(p_begin);
      3: RemoveList(p_begin);
      4: begin
           write('Введите позицию для вставки: ');
           readln(n);
           AddElement(p_begin, n);
         end;
      5: begin
           write('Введите позицию элемента для удаления: ');
           readln(n);
           DeleteElement(p_begin, n);
         end;
      0: writeln('Программа завершена.');
    else
      writeln('Неверный выбор. Попробуйте снова.');
    end;
    
  until choice = 0;
  
  if p_begin <> nil then
    RemoveList(p_begin);
end.