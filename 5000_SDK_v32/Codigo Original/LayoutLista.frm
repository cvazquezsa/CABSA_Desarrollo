[Forma]
Clave=LayoutLista
Nombre=Listas
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Info.Layout
PosicionInicialIzquierda=604
PosicionInicialArriba=389
PosicionInicialAlturaCliente=401
PosicionInicialAncho=723
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
PosicionCol1=482

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=LayoutLista
Fuente={Tahoma, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
HojaMostrarColumnas=S
HojaMantenerSeleccion=S
HojaTitulos=S
OtroOrden=S
ListaOrden=LayoutLista.Orden<TAB>(Acendente)
FiltroGeneral=LayoutLista.Layout=<T>{Info.Layout}<T>

[Lista.LayoutLista.Lista]
Carpeta=Lista
Clave=LayoutLista.Lista
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

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

[Lista.Columnas]
Lista=171
Orden=37
Nombre=241

[Acciones.Campos]
Nombre=Campos
Boton=47
NombreEnBoton=S
NombreDesplegar=&Campos
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=LayoutCampo
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(LayoutLista:LayoutLista.Lista)
Antes=S
AntesExpresiones=Asigna(Info.Lista, LayoutLista:LayoutLista.Lista)
Visible=S

[Lista.LayoutLista.Orden]
Carpeta=Lista
Clave=LayoutLista.Orden
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Columnas]
IDComienzo=604
IDComienzoPosicion=64
IDComienzoBrincar=64
IDFin=604
IDFinPosicion=64
IDFinBrincar=64

[Comienzo]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Comienzo Registro
Clave=Comienzo
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=LayoutLista
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
CondicionVisible=Ver.Columna2=<T>Comienzo - Fin<T>

[Comienzo.LayoutLista.IDComienzo]
Carpeta=Comienzo
Clave=LayoutLista.IDComienzo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Comienzo.LayoutLista.IDComienzoPosicion]
Carpeta=Comienzo
Clave=LayoutLista.IDComienzoPosicion
Editar=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[Fin]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Fin Registro
Clave=Fin
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=LayoutLista
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
CondicionVisible=Ver.Columna2=<T>Comienzo - Fin<T>

[Fin.LayoutLista.IDFin]
Carpeta=Fin
Clave=LayoutLista.IDFin
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Fin.LayoutLista.IDFinPosicion]
Carpeta=Fin
Clave=LayoutLista.IDFinPosicion
Editar=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[Lista.LayoutLista.Nombre]
Carpeta=Lista
Clave=LayoutLista.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Registro]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Registro
Clave=Registro
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=LayoutLista
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
CondicionVisible=Ver.Columna2=<T>Cada Registro<T>

[Registro.LayoutLista.IDRegistro]
Carpeta=Registro
Clave=LayoutLista.IDRegistro
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Registro.LayoutLista.IDRegistroPosicion]
Carpeta=Registro
Clave=LayoutLista.IDRegistroPosicion
Editar=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=5

[Registro.LayoutLista.IDRegistro2]
Carpeta=Registro
Clave=LayoutLista.IDRegistro2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Registro.LayoutLista.IDRegistro2Posicion]
Carpeta=Registro
Clave=LayoutLista.IDRegistro2Posicion
Editar=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Registro
Registro=Comienzo
Comienzo=Fin
Fin=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Campos
Campos=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=LayoutLista.Lista
LayoutLista.Lista=LayoutLista.Nombre
LayoutLista.Nombre=LayoutLista.Orden
LayoutLista.Orden=(Fin)

[Comienzo.ListaEnCaptura]
(Inicio)=LayoutLista.IDComienzo
LayoutLista.IDComienzo=LayoutLista.IDComienzoPosicion
LayoutLista.IDComienzoPosicion=(Fin)

[Fin.ListaEnCaptura]
(Inicio)=LayoutLista.IDFin
LayoutLista.IDFin=LayoutLista.IDFinPosicion
LayoutLista.IDFinPosicion=(Fin)

[Registro.ListaEnCaptura]
(Inicio)=LayoutLista.IDRegistro
LayoutLista.IDRegistro=LayoutLista.IDRegistroPosicion
LayoutLista.IDRegistroPosicion=LayoutLista.IDRegistro2
LayoutLista.IDRegistro2=LayoutLista.IDRegistro2Posicion
LayoutLista.IDRegistro2Posicion=(Fin)
