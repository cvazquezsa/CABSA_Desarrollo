[Forma]
Clave=AutoCorridaRolComision
Nombre=Tipos Comisi�n
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
VentanaTipoMarco=Di�logo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
PosicionInicialIzquierda=376
PosicionInicialArriba=200
PosicionInicialAlturaCliente=333
PosicionInicialAncho=271
Comentarios=Info.Rol

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=AutoCorridaRolComision
Fuente={Tahoma, 8, Negro, []}
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Autom�tica
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=AutoCorridaRolComision.Comision
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
HojaMostrarRenglones=S
FiltroGeneral=AutoCorridaRolComision.Corrida=<T>{Info.Corrida}<T> AND AutoCorridaRolComision.Rol=<T>{Info.Rol}<T>

[Lista.AutoCorridaRolComision.Comision]
Carpeta=Lista
Clave=AutoCorridaRolComision.Comision
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
Comision=242