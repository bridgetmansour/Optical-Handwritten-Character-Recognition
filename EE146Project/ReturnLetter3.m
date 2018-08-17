function [Sentence] = ReturnLetter3(num)
chr = [];
for i = 1:length(num)

switch(num(i))
   case 1
      disp('A')
      chr = [chr 'A'];
   case 2
      disp('B')
      chr = [chr 'B'];
   case 3
      disp('C')
      chr = [chr 'C'];
   case 4
      disp('D')
      chr = [chr 'D'];
   case 5
      disp('E')
      chr = [chr 'E'];
   case 6
      disp('F')
      chr = [chr 'F'];
   case 7
      disp('G')
      chr = [chr 'G'];
   case 8
      disp('H')
      chr = [chr 'H'];
   case 9
      disp('I')
      chr = [chr 'I'];
   case 10
      disp('J')
      chr = [chr 'J'];
   case 11
      disp('K')
      chr = [chr 'K'];
   case 12
      disp('L')
      chr = [chr 'L'];
   case 13
      disp('M')
      chr = [chr 'M'];
   case 14
      disp('N')
      chr = [chr 'N'];
   case 15
      disp('O')
      chr = [chr 'O'];
   case 16
      disp('P')
      chr = [chr 'P'];
   case 17
      disp('Q')
      chr = [chr 'Q'];
   case 18
      disp('R')
      chr = [chr 'R'];
   case 19
      disp('S')
      chr = [chr 'S'];
   case 20
      disp('T')
      chr = [chr 'T'];
   case 21
      disp('U')
      chr = [chr 'U'];
   case 22
      disp('V')
      chr = [chr 'V'];
   case 23
      disp('W')
      chr = [chr 'W'];
   case 24
      disp('X')
      chr = [chr 'X'];
   case 25
      disp('Y')
      chr = [chr 'Y'];
   case 26
      disp('Z')
      chr = [chr 'Z'];
   case 27
      disp(' ');
      chr = [chr ' '];
    otherwise
        disp('')
        chr = [chr];
      
end

Sentence = chr;

end



