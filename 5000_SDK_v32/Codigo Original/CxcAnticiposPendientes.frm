[Forma]
Clave=CxcAnticiposPendientes
Nombre=Anticipos Facturados Pendientes
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=299
PosicionInicialArriba=148
PosicionInicialAlturaCliente=419
PosicionInicialAncho=747
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(Info.Cliente, Info.Nombre)
VentanaExclusiva=S

VentanaEstadoInicial=Normal
[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CxcAnticiposPendientes
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
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
MenuLocal=S
ListaAcciones=Copiar

FiltroGeneral=Cxc.Empresa=<T>{Empresa}<T> <BR>AND Cxc.Estatus IN (<T>PENDIENTE<T>, <T>CONCLUIDO<T>) <BR>AND Cxc.AnticipoSaldo>0<BR>AND Cxc.Cliente=<T>{Info.Cliente}<T>
[Lista.Cxc.Mov]
Carpeta=Lista
Clave=Cxc.Mov
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.Cxc.MovID]
Carpeta=Lista
Clave=Cxc.MovID
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.Cxc.FechaEmision]
Carpeta=Lista
Clave=Cxc.FechaEmision
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.Cxc.Concepto]
Carpeta=Lista
Clave=Cxc.Concepto
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco


[Lista.Cxc.AnticipoAplicar]
Carpeta=Lista
Clave=Cxc.AnticipoAplicar
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
EditarConBloqueo=S

[Lista.Columnas]
Mov=124
MovID=64
FechaEmision=74
Concepto=94
AnticipoSaldo=96
AnticipoAplicar=91
Referencia=96

Importe=64
Impuestos=64
Retencion=64
Moneda=64
[Lista.Cxc.Referencia]
Carpeta=Lista
Clave=Cxc.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
GuardarAntes=S
Antes=S
DespuesGuardar=S

AntesExpresiones=Si Config.CxcAnticipoTipoServicio = Falso Entonces<BR>  EjecutarSQL(<T>spCxcAnticiposPendientesAceptar :tModulo, :nID<T>, Info.Modulo, Info.ID)<BR>Fin
[Acciones.Copiar]
Nombre=Copiar
Boton=0
UsaTeclaRapida=S
TeclaRapida=F5
NombreDesplegar=Copiar
EnMenu=S
TipoAccion=Expresion
Expresion=Asigna(CxcAnticiposPendientes:Cxc.AnticipoAplicar, CxcAnticiposPendientes:Cxc.AnticipoSaldo)
Activo=S
Visible=S

[Acciones.Cancelar.Cancelar Cambios]
Nombre=Cancelar Cambios
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Cancelar Cambios
Activo=S
Visible=S

[Acciones.Cancelar.Cancelar]
Nombre=Cancelar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreEnBoton=S
NombreDesplegar=<T>&Cancelar<T>
Multiple=S
EnBarraHerramientas=S
TipoAccion=Ventana
ListaAccionesMultiples=Cancelar Cambios<BR>Cancelar
Activo=S
Visible=S












[Lista.Cxc.AnticipoSaldo]
Carpeta=Lista
Clave=Cxc.AnticipoSaldo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco






[Lista.ListaEnCaptura]
(Inicio)=Cxc.Mov
Cxc.Mov=Cxc.MovID
Cxc.MovID=Cxc.FechaEmision
Cxc.FechaEmision=Cxc.Referencia
Cxc.Referencia=Cxc.Concepto
Cxc.Concepto=Cxc.AnticipoSaldo
Cxc.AnticipoSaldo=Cxc.Moneda
Cxc.Moneda=Cxc.AnticipoAplicar
Cxc.AnticipoAplicar=(Fin)

[Lista.Cxc.Moneda]
Carpeta=Lista
Clave=Cxc.Moneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco















[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=(Fin)
