
[Forma]
Clave=DIOTIVARubro
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=DPIVA - Rubros
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=(Lista)
PosicionInicialIzquierda=418
PosicionInicialArriba=168
PosicionInicialAlturaCliente=354
PosicionInicialAncho=530
ListaCarpetas=Lista
CarpetaPrincipal=Lista
[Acciones.GuardarCerrar]
Nombre=GuardarCerrar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Lista]
Estilo=Hoja
PestanaOtroNombre=S
PestanaNombre=Lista
Clave=Lista
OtroOrden=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=DIOTIVARubro
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

ListaOrden=DIOTIVARubro.Rubro<TAB>(Acendente)
CarpetaVisible=S
[Lista.ListaEnCaptura]
(Inicio)=DIOTIVARubro.Rubro
DIOTIVARubro.Rubro=DIOTIVARubro.Descripcion
DIOTIVARubro.Descripcion=DIOTIVARubro.Signo
DIOTIVARubro.Signo=(Fin)

[Lista.DIOTIVARubro.Rubro]
Carpeta=Lista
Clave=DIOTIVARubro.Rubro
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.DIOTIVARubro.Descripcion]
Carpeta=Lista
Clave=DIOTIVARubro.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Lista.DIOTIVARubro.Signo]
Carpeta=Lista
Clave=DIOTIVARubro.Signo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=8
ColorFondo=Blanco

[Lista.Columnas]
Rubro=49
Descripcion=348
Signo=79

[Acciones.Condicion]
Nombre=Condicion
Boton=6
NombreEnBoton=S
NombreDesplegar=&Condición
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=DIOTIVARubroCondicion
Activo=S
Visible=S







GuardarAntes=S
Antes=S
DespuesGuardar=S




AntesExpresiones=Asigna(Info.ID, DIOTIVARubro:DIOTIVARubro.Rubro)<BR>Asigna(Info.Anuncio, DIOTIVARubro:DIOTIVARubro.Descripcion)




















































































































[Forma.ListaAcciones]
(Inicio)=GuardarCerrar
GuardarCerrar=Condicion
Condicion=(Fin)
