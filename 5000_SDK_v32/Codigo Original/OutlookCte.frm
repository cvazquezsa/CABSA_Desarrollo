[Forma]
Clave=OutlookCte
Nombre=Mensajes del Cliente
Icono=60
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=De
PosicionInicialIzquierda=206
PosicionInicialArriba=248
PosicionInicialAlturaCliente=500
PosicionInicialAncho=867
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(Info.Tipo, Info.Cliente)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado

VentanaEstadoInicial=Normal
VentanaExclusivaMDI=S
VentanaExclusiva=S
VentanaExclusivaOpcion=3
ExpresionesAlMostrar=Asigna(Info.Tipo, <T>Correo<T>)
[De]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Recibidos 
Clave=De
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=OutlookDeCte
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
CarpetaVisible=S
PermiteLocalizar=S
MenuLocal=S
ListaAcciones=(Lista)
FiltroGrupo1=OutlookDeCte.Año
FiltroGrupo2=OutlookDeCte.Mes
FiltroGrupo3=OutlookDeCte.Dia
FiltroTodo=S
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
HojaMantenerSeleccion=S
OtroOrden=S
ListaOrden=OutlookDeCte.OutlookID<TAB>(Decendente)
FiltroGeneral=OutlookDeCte.Cliente=<T>{Info.Cliente}<T> AND OutlookDeCte.Tipo=<T>{Info.Tipo}<T>

[De.OutlookDeCte.Fecha]
Carpeta=De
Clave=OutlookDeCte.Fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[De.OutlookDeCte.Asunto]
Carpeta=De
Clave=OutlookDeCte.Asunto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[De.Columnas]
De=181
Fecha=127
Asunto=364
0=239
1=393

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Para]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Enviados
Clave=Para
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=OutlookParaCte
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
PermiteLocalizar=S
MenuLocal=S
ListaAcciones=(Lista)
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
FiltroGrupo1=OutlookParaCte.Año
FiltroGrupo2=OutlookParaCte.Mes
FiltroGrupo3=OutlookParaCte.Dia
FiltroTodo=S
HojaMantenerSeleccion=S
OtroOrden=S
ListaOrden=OutlookParaCte.OutlookID<TAB>(Decendente)
FiltroGeneral=OutlookParaCte.Cliente=<T>{Info.Cliente}<T> AND OutlookParaCte.Tipo=<T>{Info.Tipo}<T>

[Para.OutlookParaCte.Asunto]
Carpeta=Para
Clave=OutlookParaCte.Asunto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
ColorFuente=Negro

[Para.OutlookParaCte.Fecha]
Carpeta=Para
Clave=OutlookParaCte.Fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=100

[Para.Columnas]
0=239
1=392
Para=143
Asunto=295
Fecha=93
De=140

[Acciones.DeLocalizar]
Nombre=DeLocalizar
Boton=0
NombreDesplegar=Localizar
EnMenu=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Localizar
Activo=S
Visible=S
UsaTeclaRapida=S
TeclaRapida=F3
EspacioPrevio=S

[Acciones.ParaLocalizar]
Nombre=ParaLocalizar
Boton=0
UsaTeclaRapida=S
TeclaRapida=F3
NombreDesplegar=&Localizar
EnMenu=S
Carpeta=Para
TipoAccion=Controles Captura
ClaveAccion=Localizar
Activo=S
Visible=S
EspacioPrevio=S

[De.OutlookDeCte.De]
Carpeta=De
Clave=OutlookDeCte.De
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Para.OutlookParaCte.Para]
Carpeta=Para
Clave=OutlookParaCte.Para
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.DeOutlook]
Nombre=DeOutlook
Boton=0
UsaTeclaRapida=S
TeclaRapida=Ctrl+I
NombreDesplegar=&Información del Mensaje
EnMenu=S
TipoAccion=Formas
ClaveAccion=Outlook
Activo=S
Visible=S
ConCondicion=S
Antes=S
EjecucionCondicion=ConDatos(OutlookDeCte:OutlookDeCte.OutlookID)
AntesExpresiones=Asigna(Info.ID, OutlookDeCte:OutlookDeCte.OutlookID)

[Para.OutlookParaCte.De]
Carpeta=Para
Clave=OutlookParaCte.De
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.DePreliminar]
Nombre=DePreliminar
Boton=0
NombreDesplegar=Presentación preliminar
EnMenu=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Acciones.DeImprimir]
Nombre=DeImprimir
Boton=0
NombreDesplegar=&Imprimir
EnMenu=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S
EspacioPrevio=S

[Acciones.DeExcel]
Nombre=DeExcel
Boton=0
NombreDesplegar=Enviar a Excel
EnMenu=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S

[Acciones.ParaImprimir]
Nombre=ParaImprimir
Boton=0
NombreDesplegar=&Imprimir
EnMenu=S
Carpeta=Para
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S
EspacioPrevio=S

[Acciones.ParaPreliminar]
Nombre=ParaPreliminar
Boton=0
NombreDesplegar=&Presentación preliminar
EnMenu=S
Carpeta=Para
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Acciones.ParaExcel]
Nombre=ParaExcel
Boton=0
NombreDesplegar=Enviar a E&xcel
EnMenu=S
Carpeta=Para
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S

[Acciones.ParaOutlook]
Nombre=ParaOutlook
Boton=0
UsaTeclaRapida=S
TeclaRapida=Ctrl+I
NombreDesplegar=&Información del Mensaje
EnMenu=S
TipoAccion=Formas
ClaveAccion=Outlook
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(OutlookParaCte:OutlookParaCte.OutlookID)
Antes=S
AntesExpresiones=Asigna(Info.ID, OutlookParaCte:OutlookParaCte.OutlookID)
Visible=S

[Acciones.DeMensaje]
Nombre=DeMensaje
Boton=0
UsaTeclaRapida=S
TeclaRapida=Ctrl+M
NombreDesplegar=&Mensaje
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=BrowserMensajeHTML(SQL(<T>SELECT Mensaje FROM Outlook WHERE ID=:nID<T>, OutlookDeCte:OutlookDeCte.OutlookID), OutlookDeCte:OutlookDeCte.Asunto)
ConCondicion=S
EjecucionCondicion=ConDatos(OutlookDeCte:OutlookDeCte.OutlookID)

[Acciones.ParaMensaje]
Nombre=ParaMensaje
Boton=0
UsaTeclaRapida=S
NombreDesplegar=&Mensaje
EnMenu=S
TipoAccion=Expresion
Activo=S
ConCondicion=S
Visible=S
TeclaRapida=Ctrl+M
Expresion=BrowserMensajeHTML(SQL(<T>SELECT Mensaje FROM Outlook WHERE ID=:nID<T>, OutlookParaCte:OutlookParaCte.OutlookID), OutlookParaCte:OutlookParaCte.Asunto)
EjecucionCondicion=ConDatos(OutlookParaCte:OutlookParaCte.OutlookID)

[Acciones.MensajeDe]
Nombre=MensajeDe
Boton=57
NombreEnBoton=S
NombreDesplegar=Mensaje &Recibido
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Expresion=BrowserMensajeHTML(SQL(<T>SELECT Mensaje FROM Outlook WHERE ID=:nID<T>, OutlookDeCte:OutlookDeCte.OutlookID), OutlookDeCte:OutlookDeCte.Asunto)
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(OutlookDeCte:OutlookDeCte.OutlookID)
Visible=S

[Acciones.MensajePara]
Nombre=MensajePara
Boton=57
NombreEnBoton=S
NombreDesplegar=Mensaje &Enviado
EnBarraHerramientas=S
TipoAccion=Expresion
Expresion=BrowserMensajeHTML(SQL(<T>SELECT Mensaje FROM Outlook WHERE ID=:nID<T>, OutlookParaCte:OutlookParaCte.OutlookID), OutlookParaCte:OutlookParaCte.Asunto)
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(OutlookParaCte:OutlookParaCte.OutlookID)
Visible=S

[Acciones.FiltroTipo]
Nombre=FiltroTipo
Boton=107
NombreEnBoton=S
NombreDesplegar=&Tipo
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S
EspacioPrevio=S
Expresion=Si<BR>  Dialogo(<T>EspecificarMensajeTipo<T>)<BR>Entonces<BR>  Forma.ActualizarTitulos<BR>  Forma.ActualizarArbol(<T>De<T>)<BR>  Forma.ActualizarArbol(<T>Para<T>)<BR>Fin



[De.ListaEnCaptura]
(Inicio)=OutlookDeCte.De
OutlookDeCte.De=OutlookDeCte.Asunto
OutlookDeCte.Asunto=OutlookDeCte.Fecha
OutlookDeCte.Fecha=(Fin)

[De.ListaAcciones]
(Inicio)=DeMensaje
DeMensaje=DeOutlook
DeOutlook=DeImprimir
DeImprimir=DePreliminar
DePreliminar=DeExcel
DeExcel=DeLocalizar
DeLocalizar=(Fin)

[Para.ListaEnCaptura]
(Inicio)=OutlookParaCte.De
OutlookParaCte.De=OutlookParaCte.Para
OutlookParaCte.Para=OutlookParaCte.Asunto
OutlookParaCte.Asunto=OutlookParaCte.Fecha
OutlookParaCte.Fecha=(Fin)

[Para.ListaAcciones]
(Inicio)=ParaMensaje
ParaMensaje=ParaOutlook
ParaOutlook=ParaImprimir
ParaImprimir=ParaPreliminar
ParaPreliminar=ParaExcel
ParaExcel=ParaLocalizar
ParaLocalizar=(Fin)







[Forma.ListaCarpetas]
(Inicio)=De
De=Para
Para=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=MensajeDe
MensajeDe=MensajePara
MensajePara=FiltroTipo
FiltroTipo=(Fin)
