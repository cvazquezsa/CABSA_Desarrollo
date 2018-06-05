[Forma]
Clave=Outlook
Nombre=Información del Correo
Icono=6
Modulos=(Todos)
ListaCarpetas=Ficha
CarpetaPrincipal=Ficha
PosicionInicialAlturaCliente=163
PosicionInicialAncho=723
PosicionInicialIzquierda=278
PosicionInicialArriba=417
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEscCerrar=S

[Ficha]
Estilo=Ficha
Clave=Ficha
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Outlook
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
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
FiltroTipo=General
FiltroGeneral=Outlook.ID={Info.ID}

[Ficha.Outlook.De]
Carpeta=Ficha
Clave=Outlook.De
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=79
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Outlook.Fecha]
Carpeta=Ficha
Clave=Outlook.Fecha
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[Ficha.Outlook.Asunto]
Carpeta=Ficha
Clave=Outlook.Asunto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Outlook.Anexos]
Carpeta=Ficha
Clave=Outlook.Anexos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

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

[Acciones.Para]
Nombre=Para
Boton=0
NombreEnBoton=S
NombreDesplegar=&Para...
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=OutlookPara
Activo=S
Visible=S
EspacioPrevio=S

[Acciones.Mensaje]
Nombre=Mensaje
Boton=57
NombreEnBoton=S
NombreDesplegar=&Mensaje
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Visible=S
Activo=S
Expresion=BrowserMensajeHTML(Outlook:Outlook.Mensaje, Outlook:Outlook.Asunto)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Para
Para=Mensaje
Mensaje=(Fin)

[Ficha.ListaEnCaptura]
(Inicio)=Outlook.De
Outlook.De=Outlook.Fecha
Outlook.Fecha=Outlook.Asunto
Outlook.Asunto=Outlook.Anexos
Outlook.Anexos=(Fin)
