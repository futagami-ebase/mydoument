FasdUAS 1.101.10   ��   ��    k             l     ����  r       	  J      
 
     m     �����   ��  m    �������   	 o      ���� 0 basesize baseSize��  ��        i         I      �� ���� 0 addwidth addWidth      o      ���� 0 currentwindow currentWindow   ��  o      ���� 0 unit  ��  ��    k            r         n         1    ��
�� 
ptsz  o     ���� 0 currentwindow currentWindow  o      ���� 0 currentsize currentSize   ��  r        J          ! " ! [     # $ # l   
 %���� % n    
 & ' & 4    
�� (
�� 
cobj ( m    	����  ' o    ���� 0 currentsize currentSize��  ��   $ o   
 ���� 0 unit   "  )�� ) l    *���� * n     + , + 4    �� -
�� 
cobj - m    ����  , o    ���� 0 currentsize currentSize��  ��  ��    n       . / . 1    ��
�� 
ptsz / o    ���� 0 currentwindow currentWindow��     0 1 0 i     2 3 2 I      �� 4���� 0 	addheight 	addHeight 4  5 6 5 o      ���� 0 currentwindow currentWindow 6  7�� 7 o      ���� 0 unit  ��  ��   3 k      8 8  9 : 9 r      ; < ; n      = > = 1    ��
�� 
ptsz > o     ���� 0 currentwindow currentWindow < o      ���� 0 currentsize currentSize :  ?�� ? r     @ A @ J     B B  C D C l   
 E���� E n    
 F G F 4    
�� H
�� 
cobj H m    	����  G o    ���� 0 currentsize currentSize��  ��   D  I�� I [   
  J K J l  
  L���� L n   
  M N M 4    �� O
�� 
cobj O m    ����  N o   
 ���� 0 currentsize currentSize��  ��   K o    ���� 0 unit  ��   A n       P Q P 1    ��
�� 
ptsz Q o    ���� 0 currentwindow currentWindow��   1  R S R l   D T���� T O    D U V U k    C W W  X Y X r     Z [ Z n     \ ] \ 4    �� ^
�� 
cobj ^ m    ����  ] l    _���� _ 6    ` a ` 2    ��
�� 
prcs a =    b c b 1    ��
�� 
pisf c m    ��
�� boovtrue��  ��   [ o      ���� 0 
currentapp 
currentApp Y  d�� d O    C e f e k   ! B g g  h i h r   ! 2 j k j n   ! 0 l m l 4   - 0�� n
�� 
cobj n m   . /����  m l  ! - o���� o 6  ! - p q p 2   ! $��
�� 
cwin q =  % , r s r 1   & (��
�� 
sbrl s m   ) + t t � u u   A X S t a n d a r d W i n d o w��  ��   k o      ���� 0 currentwindow currentWindow i  v w v I   3 :�� x���� 0 addwidth addWidth x  y z y o   4 5���� 0 currentwindow currentWindow z  {�� { m   5 6���� ��  ��   w  |�� | I   ; B�� }���� 0 	addheight 	addHeight }  ~  ~ o   < =���� 0 currentwindow currentWindow   ��� � m   = >���� ��  ��  ��   f o    ���� 0 
currentapp 
currentApp��   V m     � ��                                                                                  sevs  alis    �  system                     �I"qH+     )System Events.app                                               ���ae        ����  	                CoreServices    �H��      ����       )   (   '  7system:System: Library: CoreServices: System Events.app   $  S y s t e m   E v e n t s . a p p    s y s t e m  -System/Library/CoreServices/System Events.app   / ��  ��  ��   S  � � � l     ��������  ��  ��   �  � � � l     ��������  ��  ��   �  � � � l     ��������  ��  ��   �  ��� � l      �� � ���   �{u
tell application "System Events"	--		set currentApp to item 1 of (every process whose frontmost is true)	tell item 1 of (every process whose frontmost is true)		--			activate		set size of window 1 to {522, 800}		set position of window 1 to {500, 36}		set size of window 1 to {522, 800}		set position of window 1 to {500, 36}	end tellend tellignoring application responsesend ignoringset frontmostApp to path to frontmost application
tell application "Finder"	set appName to name of frontmostAppend tellif appName ends with ".app" then	set appName to text 1 thru -5 of appNameend iftell application "Finder"	set appName to name of frontmostAppend tellactivate application appNametell application appName	tell document 1		set selectedWord to contents of selection		display dialog selectedWord	end tellend tell--�Ƃ肠�����A���܂������Ă���̂��ǂ����H�H
    � � � �� 
 t e l l   a p p l i c a t i o n   " S y s t e m   E v e n t s "  	 - - 	 	 s e t   c u r r e n t A p p   t o   i t e m   1   o f   ( e v e r y   p r o c e s s   w h o s e   f r o n t m o s t   i s   t r u e )  	 t e l l   i t e m   1   o f   ( e v e r y   p r o c e s s   w h o s e   f r o n t m o s t   i s   t r u e )  	 	 - - 	 	 	 a c t i v a t e  	 	 s e t   s i z e   o f   w i n d o w   1   t o   { 5 2 2 ,   8 0 0 }  	 	 s e t   p o s i t i o n   o f   w i n d o w   1   t o   { 5 0 0 ,   3 6 }  	 	 s e t   s i z e   o f   w i n d o w   1   t o   { 5 2 2 ,   8 0 0 }  	 	 s e t   p o s i t i o n   o f   w i n d o w   1   t o   { 5 0 0 ,   3 6 }  	 e n d   t e l l  e n d   t e l l  i g n o r i n g   a p p l i c a t i o n   r e s p o n s e s  e n d   i g n o r i n g    s e t   f r o n t m o s t A p p   t o   p a t h   t o   f r o n t m o s t   a p p l i c a t i o n 
 t e l l   a p p l i c a t i o n   " F i n d e r "  	 s e t   a p p N a m e   t o   n a m e   o f   f r o n t m o s t A p p  e n d   t e l l   i f   a p p N a m e   e n d s   w i t h   " . a p p "   t h e n  	 s e t   a p p N a m e   t o   t e x t   1   t h r u   - 5   o f   a p p N a m e  e n d   i f  t e l l   a p p l i c a t i o n   " F i n d e r "  	 s e t   a p p N a m e   t o   n a m e   o f   f r o n t m o s t A p p  e n d   t e l l  a c t i v a t e   a p p l i c a t i o n   a p p N a m e   t e l l   a p p l i c a t i o n   a p p N a m e  	 t e l l   d o c u m e n t   1  	 	 s e t   s e l e c t e d W o r d   t o   c o n t e n t s   o f   s e l e c t i o n  	 	 d i s p l a y   d i a l o g   s e l e c t e d W o r d  	 e n d   t e l l  e n d   t e l l  - -0h0�0B0H0Z00F0~0O0D0c0f0D0�0n0K0i0F0K�� 
��       �� � � � ���   � �������� 0 addwidth addWidth�� 0 	addheight 	addHeight
�� .aevtoappnull  �   � **** � �� ���� � ����� 0 addwidth addWidth�� �� ���  �  ������ 0 currentwindow currentWindow�� 0 unit  ��   � �������� 0 currentwindow currentWindow�� 0 unit  �� 0 currentsize currentSize � ����
�� 
ptsz
�� 
cobj�� ��,E�O��k/���l/lv��,F � �� 3���� � ����� 0 	addheight 	addHeight�� �� ���  �  ������ 0 currentwindow currentWindow�� 0 unit  ��   � �������� 0 currentwindow currentWindow�� 0 unit  �� 0 currentsize currentSize � ����
�� 
ptsz
�� 
cobj�� ��,E�O��k/��l/�lv��,F � �� ����� � ���
�� .aevtoappnull  �   � **** � k     D � �   � �  R����  ��  ��   �   � ����~ ��} ��|�{�z�y�x t�w�v�u�t������~ 0 basesize baseSize
�} 
prcs �  
�| 
pisf
�{ 
cobj�z 0 
currentapp 
currentApp
�y 
cwin
�x 
sbrl�w 0 currentwindow currentWindow�v �u 0 addwidth addWidth�t 0 	addheight 	addHeight�� E��lvE�O� :*�-�[�,\Ze81�k/E�O� #*�-�[�,\Z�81�k/E�O*��l+ O*��l+ UU ascr  ��ޭ