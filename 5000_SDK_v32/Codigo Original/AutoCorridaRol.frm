[Forma]
Clave=AutoCorridaRol
Nombre=Roles de la Corrida
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
Comentarios=Info.Corrida
ListaAcciones=(Lista)
PosicionInicialIzquierda=345
PosicionInicialArriba=214
PosicionInicialAlturaCliente=305
PosicionInicialAncho=364

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=AutoCorridaRol
Fuente={Tahoma, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=AutoCorridaRol.Rol
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroGeneral=AutoCorridaRol.Corrida=<T>{Info.Corrida}<T>
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S

[Lista.AutoCorridaRol.Rol]
Carpeta=Lista
Clave=AutoCorridaRol.Rol
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
Rol=335

[Acciones.Comision]
Nombre=Comision
Boton=61
NombreEnBoton=S
NombreDesplegar=&Tipos Comisión
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=AutoCorridaRolComision
Activo=S
ConCondicion=S
Antes=S
Visible=S
EspacioPrevio=S
EjecucionCondicion=ConDatos(AutoCorridaRol:AutoCorridaRol.Rol)
AntesExpresiones=Asigna(Info.Rol, AutoCorridaRol:AutoCorridaRol.Rol)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Comision
Comision=(Fin)
