[Forma]
Clave=NominaImportar
Nombre=NominaImportar
Icono=0
Modulos=(Todos)
MovModulo=RH
ListaCarpetas=(Lista)
CarpetaPrincipal=Lista
PosicionInicialAlturaCliente=409
PosicionInicialAncho=846
PosicionInicialIzquierda=153
PosicionInicialArriba=214
PosicionSeccion1=13
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
Comentarios=NominaImportar:NominaImportar.ID
PosicionSec1=45

[Lista]
Estilo=Ficha
PestanaNombre=Datos Generales
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=(Variables)
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S

[Lista.Info.FechaD]
Carpeta=Lista
Clave=Info.FechaD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Info.FechaA]
Carpeta=Lista
Clave=Info.FechaA
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[NominaImportar]
Estilo=Hoja
Clave=NominaImportar
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=NominaImportar
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
PermiteEditar=S
Filtros=S
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
ValidarCampos=S
ListaCamposAValidar=PersonalA.NombreCompleto
ControlRenglon=S
CampoRenglon=NominaImportar.Renglon
OtroOrden=S
ListaOrden=NominaImportar.Renglon<TAB>(Acendente)
ListaEnCaptura=(Lista)
FiltroGeneral=NominaImportar.ID={info.id}<BR>and NominaImportar.Usuario=<T>{Usuario}<T>

[NominaImportar.Columnas]
Personal=64
Cantidad=64
Importe=64
NominaConcepto=85
Concepto=304
Estastus=94
Estatus=94
Movimiento=124

[Acciones.Enviar/Recibir Excel]
Nombre=Enviar/Recibir Excel
Boton=67
NombreDesplegar=Enviar/Recibir Excel
EnBarraHerramientas=S
Carpeta=NominaImportar
TipoAccion=Controles Captura
ClaveAccion=Enviar/Recibir Excel
Activo=S
Visible=S
GuardarAntes=S
RefrescarDespues=S

[Acciones.Guardar Cambios]
Nombre=Guardar Cambios
Boton=3
NombreDesplegar=Guardar Cambios
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S
GuardarAntes=S
RefrescarDespues=S
Expresion=Forma.ActualizarForma  <BR>Forma.ActualizarVista

[Acciones.Generarcerrar]
Nombre=Generarcerrar
Boton=7
NombreEnBoton=S
NombreDesplegar=&Generar  y Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
Activo=S
Visible=S
GuardarAntes=S
ClaveAccion=Cerrar
Antes=S
AntesExpresiones=Forma.GenerarRenglones <BR>GuardarCambios <BR>ProcesarSQL(<T>EXEC spNominaInsertarAcumulado :ni, :tu, :tdf, :taf<T>, Info.ID, Usuario, FechaFormatoServidor(Info.FechaD), FechaFormatoServidor(Info.FechaA))

[NominaImportar.NominaImportar.Personal]
Carpeta=NominaImportar
Clave=NominaImportar.Personal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[NominaImportar.NominaImportar.Cantidad]
Carpeta=NominaImportar
Clave=NominaImportar.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[NominaImportar.NominaImportar.Importe]
Carpeta=NominaImportar
Clave=NominaImportar.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[NominaImportar.NominaImportar.NominaConcepto]
Carpeta=NominaImportar
Clave=NominaImportar.NominaConcepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[NominaImportar.NominaImportar.Concepto]
Carpeta=NominaImportar
Clave=NominaImportar.Concepto
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[NominaImportar.NominaImportar.Movimiento]
Carpeta=NominaImportar
Clave=NominaImportar.Movimiento
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[NominaImportar.NominaImportar.Estatus]
Carpeta=NominaImportar
Clave=NominaImportar.Estatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=S

[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=NominaImportar
NominaImportar=(Fin)

[Forma.ListaAcciones]
(Inicio)=Guardar Cambios
Guardar Cambios=Enviar/Recibir Excel
Enviar/Recibir Excel=Generarcerrar
Generarcerrar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=Info.FechaD
Info.FechaD=Info.FechaA
Info.FechaA=(Fin)

[NominaImportar.ListaEnCaptura]
(Inicio)=NominaImportar.Personal
NominaImportar.Personal=NominaImportar.Cantidad
NominaImportar.Cantidad=NominaImportar.Importe
NominaImportar.Importe=NominaImportar.NominaConcepto
NominaImportar.NominaConcepto=NominaImportar.Concepto
NominaImportar.Concepto=NominaImportar.Movimiento
NominaImportar.Movimiento=NominaImportar.Estatus
NominaImportar.Estatus=(Fin)
