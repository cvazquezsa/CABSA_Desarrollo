[Forma]
Clave=PersonalCB
Nombre=Códigos Barras - Personal
Icono=49
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=221
PosicionInicialArriba=140
PosicionInicialAltura=487
PosicionInicialAncho=582
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=PersonalCB
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
CarpetaVisible=S
PermiteLocalizar=S
Filtros=S
FiltroPredefinido1=por Código Barras<BR>por Personal
FiltroPredefinido3=Codigo<BR>Cuenta
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroEstilo=Directorio
FiltroRespetar=S
FiltroTipo=Predefinido
FiltroPredefinido2=TipoCuenta=<T>Personal<T><BR>TipoCuenta=<T>Personal<T>
BusquedaRapidaControles=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
HojaConfirmarEliminar=S

[Lista.PersonalCB.Codigo]
Carpeta=Lista
Clave=PersonalCB.Codigo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.PersonalCB.Cuenta]
Carpeta=Lista
Clave=PersonalCB.Cuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Codigo=124
Cuenta=111
Descripcion1=188
SubCuenta=111
Cantidad=51
Unidad=54
NombreCompleto=238
NombreEstatus=77

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

[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreDesplegar=&Guardar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
Visible=S
NombreEnBoton=S

[Acciones.Vista]
Nombre=Vista
Boton=0
NombreDesplegar=Cambiar Vista Hoja (Normal-Detalle)
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Herramientas Captura
ClaveAccion=Cambiar Vista Hoja (Normal-Detalle)
Activo=S
Visible=S

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreEnBoton=S
NombreDesplegar=E&liminar
EnBarraHerramientas=S
ConfirmarAntes=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S

[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Enviar/Recibir Excel
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar/Recibir Excel
Activo=S
Visible=S

[Acciones.Reporte]
Nombre=Reporte
Boton=68
NombreDesplegar=&Reporte
EnBarraHerramientas=S
TipoAccion=Reportes Pantalla
ClaveAccion=CB
ListaParametros1=<T>Personal<T>
ListaParametros=S
Activo=S
Visible=S

[Acciones.Sugerir]
Nombre=Sugerir
Boton=1
NombreEnBoton=S
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S
GuardarAntes=S
Multiple=S
ListaAccionesMultiples=Agregar<BR>Expresion
EspacioPrevio=S

[Acciones.Sugerir.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Expresion=Asigna(PersonalCB:PersonalCB.Codigo, SQL(<T>SELECT MAX(convert(money, Codigo))+1 FROM CB WHERE isnumeric(Codigo) = 1<T>))
Activo=S
Visible=S

[Acciones.Sugerir.Agregar]
Nombre=Agregar
Boton=0
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Agregar
Activo=S
Visible=S

[Lista.NombreCompleto]
Carpeta=Lista
Clave=NombreCompleto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Gris

[Lista.NombreEstatus]
Carpeta=Lista
Clave=NombreEstatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Gris

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Guardar
Guardar=Sugerir
Sugerir=Eliminar
Eliminar=Vista
Vista=Excel
Excel=Reporte
Reporte=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=PersonalCB.Codigo
PersonalCB.Codigo=PersonalCB.Cuenta
PersonalCB.Cuenta=NombreCompleto
NombreCompleto=NombreEstatus
NombreEstatus=(Fin)
