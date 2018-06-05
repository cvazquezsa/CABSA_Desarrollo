[Forma]
Clave=CtaSituacion
Nombre=<T>Situaciones - <T>+Info.Descripcion
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Lista
PosicionInicialAltura=356
PosicionInicialAncho=617
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=411
PosicionInicialArriba=272
PosicionInicialAlturaCliente=329
PosicionColumna1=79
PosicionCol1=440

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CtaSituacion
Fuente={Tahoma, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
HojaMantenerSeleccion=S
HojaTitulos=S
HojaMostrarColumnas=S
FiltroGeneral=CtaSituacion.Rama=<T>{Info.Rama}<T>

[Lista.CtaSituacion.Situacion]
Carpeta=Lista
Clave=CtaSituacion.Situacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Situacion=262
Color=146

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
ConCondicion=S
EjecucionCondicion=Asigna(Temp.Texto, ListaBuscarDuplicados(CampoEnLista(CtaSituacion:CtaSituacion.Situacion)))<BR>Vacio(Temp.Texto)
EjecucionMensaje=Comillas(Temp.Texto)+<T> Duplicada<T>
EjecucionConError=S

[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Enviar/Recibir Excel
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar/Recibir Excel
Visible=S
ActivoCondicion=Usuario.EnviarExcel

[Icono]
Estilo=Ficha
Clave=Icono
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=CtaSituacion
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
ListaEnCaptura=CtaSituacion.Icono
CarpetaVisible=S

Pestana=S
PestanaOtroNombre=S
PestanaNombre=Ícono
[Icono.CtaSituacion.Icono]
Carpeta=Icono
Clave=CtaSituacion.Icono
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CtaSituacion.Color]
Carpeta=Lista
Clave=CtaSituacion.Color
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro



[Lista.ListaEnCaptura]
(Inicio)=CtaSituacion.Situacion
CtaSituacion.Situacion=CtaSituacion.Color
CtaSituacion.Color=(Fin)




[Icono.ListaEnCaptura]
(Inicio)=CtaSituacion.Icono
CtaSituacion.Icono=CtaSituacion.CampanaMov
CtaSituacion.CampanaMov=CtaSituacion.CampanaMovID
CtaSituacion.CampanaMovID=(Fin)







[Campana]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Campaña
Clave=Campana
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=CtaSituacion
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

GuardarAlSalir=S

PermiteEditar=S
CondicionVisible=((Info.Rama = <T>CXC<T>) Y (Info.Descripcion = <T>Clientes<T>)) O ((Info.Rama = <T>CXP<T>) Y (Info.Descripcion = <T>Proveedores<T>)) O ((Info.Rama = <T>CMP<T>) Y (Info.Descripcion = <T>Prospectos<T>)) O ((Info.Rama = <T>RH<T>) Y (Info.Descripcion = <T>Personal<T>))
[Campana.CtaSituacion.CampanaMov]
Carpeta=Campana
Clave=CtaSituacion.CampanaMov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Campana.CtaSituacion.CampanaMovID]
Carpeta=Campana
Clave=CtaSituacion.CampanaMovID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro










[Campana.ListaEnCaptura]
(Inicio)=CtaSituacion.CampanaMov
CtaSituacion.CampanaMov=CtaSituacion.CampanaMovID
CtaSituacion.CampanaMovID=(Fin)

[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Icono
Icono=Campana
Campana=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Excel
Excel=(Fin)
