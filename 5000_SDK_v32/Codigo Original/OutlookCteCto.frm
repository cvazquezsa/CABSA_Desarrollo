[Forma]
Clave=OutlookCteCto
Nombre=Mensajes del Contacto
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
Vista=OutlookDeCteCto
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
FiltroGrupo1=OutlookDeCteCto.Año
FiltroGrupo2=OutlookDeCteCto.Mes
FiltroGrupo3=OutlookDeCteCto.Dia
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
ListaOrden=OutlookDeCteCto.OutlookID<TAB>(Decendente)
FiltroGeneral=OutlookDeCteCto.Cliente=<T>{Info.Cliente}<T> AND<BR>OutlookDeCteCto.ClienteContacto={Info.ClienteContacto} AND<BR>OutlookDeCteCto.Tipo=<T>{Info.Tipo}<T>

[De.OutlookDeCteCto.Fecha]
Carpeta=De
Clave=OutlookDeCteCto.Fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[De.OutlookDeCteCto.Asunto]
Carpeta=De
Clave=OutlookDeCteCto.Asunto
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
Vista=OutlookParaCteCto
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
FiltroGrupo1=OutlookParaCteCto.Año
FiltroGrupo2=OutlookParaCteCto.Mes
FiltroGrupo3=OutlookParaCteCto.Dia
FiltroTodo=S
HojaMantenerSeleccion=S
OtroOrden=S
ListaOrden=OutlookParaCteCto.OutlookID<TAB>(Decendente)
FiltroGeneral=OutlookParaCteCto.Cliente=<T>{Info.Cliente}<T> AND<BR>OutlookParaCteCto.ClienteContacto={Info.ClienteContacto} AND<BR>OutlookParaCteCto.Tipo=<T>{Info.Tipo}<T>

[Para.OutlookParaCteCto.Asunto]
Carpeta=Para
Clave=OutlookParaCteCto.Asunto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
ColorFuente=Negro

[Para.OutlookParaCteCto.Fecha]
Carpeta=Para
Clave=OutlookParaCteCto.Fecha
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

[De.OutlookDeCteCto.De]
Carpeta=De
Clave=OutlookDeCteCto.De
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Para.OutlookParaCteCto.Para]
Carpeta=Para
Clave=OutlookParaCteCto.Para
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
EjecucionCondicion=ConDatos(OutlookDeCteCto:OutlookDeCteCto.OutlookID)
AntesExpresiones=Asigna(Info.ID, OutlookDeCteCto:OutlookDeCteCto.OutlookID)

[Para.OutlookParaCteCto.De]
Carpeta=Para
Clave=OutlookParaCteCto.De
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
EjecucionCondicion=ConDatos(OutlookParaCteCto:OutlookParaCteCto.OutlookID)
Antes=S
AntesExpresiones=Asigna(Info.ID, OutlookParaCteCto:OutlookParaCteCto.OutlookID)
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
Expresion=BrowserMensajeHTML(SQL(<T>SELECT Mensaje FROM Outlook WHERE ID=:nID<T>, OutlookDeCteCto:OutlookDeCteCto.OutlookID), OutlookDeCteCto:OutlookDeCteCto.Asunto)
ConCondicion=S
EjecucionCondicion=ConDatos(OutlookDeCteCto:OutlookDeCteCto.OutlookID)

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
Expresion=BrowserMensajeHTML(SQL(<T>SELECT Mensaje FROM Outlook WHERE ID=:nID<T>, OutlookParaCteCto:OutlookParaCteCto.OutlookID), OutlookParaCteCto:OutlookParaCteCto.Asunto)
EjecucionCondicion=ConDatos(OutlookParaCteCto:OutlookParaCteCto.OutlookID)

[Acciones.MensajeDe]
Nombre=MensajeDe
Boton=57
NombreEnBoton=S
NombreDesplegar=Mensaje &Recibido
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Expresion=BrowserMensajeHTML(SQL(<T>SELECT Mensaje FROM Outlook WHERE ID=:nID<T>, OutlookDeCteCto:OutlookDeCteCto.OutlookID), OutlookDeCteCto:OutlookDeCteCto.Asunto)
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(OutlookDeCteCto:OutlookDeCteCto.OutlookID)
Visible=S

[Acciones.MensajePara]
Nombre=MensajePara
Boton=57
NombreEnBoton=S
NombreDesplegar=Mensaje &Enviado
EnBarraHerramientas=S
TipoAccion=Expresion
Expresion=BrowserMensajeHTML(SQL(<T>SELECT Mensaje FROM Outlook WHERE ID=:nID<T>, OutlookParaCteCto:OutlookParaCteCto.OutlookID), OutlookParaCteCto:OutlookParaCteCto.Asunto)
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(OutlookParaCteCto:OutlookParaCteCto.OutlookID)
Visible=S

[Acciones.Filtro]
Nombre=Filtro
Boton=107
NombreEnBoton=S
NombreDesplegar=&Tipo
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S
EspacioPrevio=S
Expresion=Si<BR>  Dialogo(<T>EspecificarMensajeTipo<T>)<BR>Entonces<BR>  Forma.ActualizarTitulos<BR>  Forma.ActualizarArbol(<T>De<T>)<BR>  Forma.ActualizarArbol(<T>Para<T>)<BR>Fin

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
(Inicio)=OutlookDeCteCto.De
OutlookDeCteCto.De=OutlookDeCteCto.Asunto
OutlookDeCteCto.Asunto=OutlookDeCteCto.Fecha
OutlookDeCteCto.Fecha=(Fin)

[De.ListaAcciones]
(Inicio)=DeMensaje
DeMensaje=DeOutlook
DeOutlook=DeImprimir
DeImprimir=DePreliminar
DePreliminar=DeExcel
DeExcel=DeLocalizar
DeLocalizar=(Fin)

[Para.ListaEnCaptura]
(Inicio)=OutlookParaCteCto.De
OutlookParaCteCto.De=OutlookParaCteCto.Para
OutlookParaCteCto.Para=OutlookParaCteCto.Asunto
OutlookParaCteCto.Asunto=OutlookParaCteCto.Fecha
OutlookParaCteCto.Fecha=(Fin)

[Para.ListaAcciones]
(Inicio)=ParaMensaje
ParaMensaje=ParaOutlook
ParaOutlook=ParaImprimir
ParaImprimir=ParaPreliminar
ParaPreliminar=ParaExcel
ParaExcel=ParaLocalizar
ParaLocalizar=(Fin)
