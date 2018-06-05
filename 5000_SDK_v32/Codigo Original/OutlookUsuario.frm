[Forma]
Clave=OutlookUsuario
Nombre=Mensajes del Usuario
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
Comentarios=Lista(Info.Tipo, Info.Usuario)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
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
Vista=OutlookDeUsuario
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
FiltroGrupo1=OutlookDeUsuario.Año
FiltroGrupo2=OutlookDeUsuario.Mes
FiltroGrupo3=OutlookDeUsuario.Dia
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
ListaOrden=OutlookDeUsuario.OutlookID<TAB>(Decendente)
FiltroGeneral=OutlookDeUsuario.Usuario=<T>{Info.Usuario}<T> AND<BR>OutlookDeUsuario.Tipo=<T>{Info.Tipo}<T>

[De.OutlookDeUsuario.Fecha]
Carpeta=De
Clave=OutlookDeUsuario.Fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[De.OutlookDeUsuario.Asunto]
Carpeta=De
Clave=OutlookDeUsuario.Asunto
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
Vista=OutlookParaUsuario
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
FiltroGrupo1=OutlookParaUsuario.Año
FiltroGrupo2=OutlookParaUsuario.Mes
FiltroGrupo3=OutlookParaUsuario.Dia
FiltroTodo=S
HojaMantenerSeleccion=S
OtroOrden=S
ListaOrden=OutlookParaUsuario.OutlookID<TAB>(Decendente)
FiltroGeneral=OutlookParaUsuario.Usuario=<T>{Info.Usuario}<T> AND<BR>OutlookParaUsuario.Tipo=<T>{Info.Tipo}<T>

[Para.OutlookParaUsuario.Asunto]
Carpeta=Para
Clave=OutlookParaUsuario.Asunto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
ColorFuente=Negro

[Para.OutlookParaUsuario.Fecha]
Carpeta=Para
Clave=OutlookParaUsuario.Fecha
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

[De.OutlookDeUsuario.De]
Carpeta=De
Clave=OutlookDeUsuario.De
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Para.OutlookParaUsuario.Para]
Carpeta=Para
Clave=OutlookParaUsuario.Para
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
EjecucionCondicion=ConDatos(OutlookDeUsuario:OutlookDeUsuario.OutlookID)
AntesExpresiones=Asigna(Info.ID, OutlookDeUsuario:OutlookDeUsuario.OutlookID)

[Para.OutlookParaUsuario.De]
Carpeta=Para
Clave=OutlookParaUsuario.De
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
EjecucionCondicion=ConDatos(OutlookParaUsuario:OutlookParaUsuario.OutlookID)
Antes=S
AntesExpresiones=Asigna(Info.ID, OutlookParaUsuario:OutlookParaUsuario.OutlookID)
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
Expresion=BrowserMensajeHTML(SQL(<T>SELECT Mensaje FROM Outlook WHERE ID=:nID<T>, OutlookDeUsuario:OutlookDeUsuario.OutlookID), OutlookDeUsuario:OutlookDeUsuario.Asunto)
ConCondicion=S
EjecucionCondicion=ConDatos(OutlookDeUsuario:OutlookDeUsuario.OutlookID)

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
Expresion=BrowserMensajeHTML(SQL(<T>SELECT Mensaje FROM Outlook WHERE ID=:nID<T>, OutlookParaUsuario:OutlookParaUsuario.OutlookID), OutlookParaUsuario:OutlookParaUsuario.Asunto)
EjecucionCondicion=ConDatos(OutlookParaUsuario:OutlookParaUsuario.OutlookID)

[Acciones.MensajeDe]
Nombre=MensajeDe
Boton=57
NombreEnBoton=S
NombreDesplegar=Mensaje &Recibido
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
ConCondicion=S
Visible=S
Expresion=BrowserMensajeHTML(SQL(<T>SELECT Mensaje FROM Outlook WHERE ID=:nID<T>, OutlookDeUsuario:OutlookDeUsuario.OutlookID), OutlookDeUsuario:OutlookDeUsuario.Asunto)
EjecucionCondicion=ConDatos(OutlookDeUsuario:OutlookDeUsuario.OutlookID)

[Acciones.MensajePara]
Nombre=MensajePara
Boton=57
NombreEnBoton=S
NombreDesplegar=Mensaje &Enviado
EnBarraHerramientas=S
TipoAccion=Expresion
Expresion=BrowserMensajeHTML(SQL(<T>SELECT Mensaje FROM Outlook WHERE ID=:nID<T>, OutlookParaUsuario:OutlookParaUsuario.OutlookID), OutlookParaUsuario:OutlookParaUsuario.Asunto)
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(OutlookParaUsuario:OutlookParaUsuario.OutlookID)
Visible=S

[Acciones.Filtro]
Nombre=Filtro
Boton=107
NombreEnBoton=S
NombreDesplegar=&Tipo
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Expresion=Si<BR>  Dialogo(<T>EspecificarMensajeTipo<T>)<BR>Entonces<BR>  Forma.ActualizarTitulos<BR>  Forma.ActualizarArbol(<T>De<T>)<BR>  Forma.ActualizarArbol(<T>Para<T>)<BR>Fin
Activo=S
Visible=S

[Forma.ListaCarpetas]
(Inicio)=De
De=Para
Para=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=MensajeDe
MensajeDe=MensajePara
MensajePara=Filtro
Filtro=(Fin)

[De.ListaEnCaptura]
(Inicio)=OutlookDeUsuario.De
OutlookDeUsuario.De=OutlookDeUsuario.Asunto
OutlookDeUsuario.Asunto=OutlookDeUsuario.Fecha
OutlookDeUsuario.Fecha=(Fin)

[De.ListaAcciones]
(Inicio)=DeMensaje
DeMensaje=DeOutlook
DeOutlook=DeImprimir
DeImprimir=DePreliminar
DePreliminar=DeExcel
DeExcel=DeLocalizar
DeLocalizar=(Fin)

[Para.ListaEnCaptura]
(Inicio)=OutlookParaUsuario.De
OutlookParaUsuario.De=OutlookParaUsuario.Para
OutlookParaUsuario.Para=OutlookParaUsuario.Asunto
OutlookParaUsuario.Asunto=OutlookParaUsuario.Fecha
OutlookParaUsuario.Fecha=(Fin)

[Para.ListaAcciones]
(Inicio)=ParaMensaje
ParaMensaje=ParaOutlook
ParaOutlook=ParaImprimir
ParaImprimir=ParaPreliminar
ParaPreliminar=ParaExcel
ParaExcel=ParaLocalizar
ParaLocalizar=(Fin)
