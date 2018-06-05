


[Forma]
Clave=MovilUsuarioCfg
Icono=0
CarpetaPrincipal=Lista
Modulos=(Todos)
MovModulo=MovilUsuarioCfg
Nombre=Configuración Móvil

ListaCarpetas=Lista
PosicionInicialIzquierda=530
PosicionInicialArriba=193
PosicionInicialAlturaCliente=266
PosicionInicialAncho=561
VentanaTipoMarco=Sencillo
VentanaPosicionInicial=por Diseño
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Guardar
VentanaExclusiva=S
VentanaAjustarZonas=S
VentanaEscCerrar=S
VentanaExclusivaOpcion=0
[Lista]
Estilo=Ficha
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MovilUsuarioCfg
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
PermiteEditar=S



Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=MovilUsuarioCfg.Empresa = {Comillas(Empresa)} AND MovilUsuarioCfg.Usuario = {Comillas(Info.Usuario)}
[Lista.MovilUsuarioCfg.Agente]
Carpeta=Lista
Clave=MovilUsuarioCfg.Agente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.Agente.Nombre]
Carpeta=Lista
Clave=Agente.Nombre
Editar=N
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=50
ColorFondo=Blanco

Pegado=S
[Lista.MovilUsuarioCfg.PedidosAConsultar]
Carpeta=Lista
Clave=MovilUsuarioCfg.PedidosAConsultar
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=10
[Lista.MovilUsuarioCfg.ContrasenaCorta]
Carpeta=Lista
Clave=MovilUsuarioCfg.ContrasenaCorta
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.MovilUsuarioCfg.IntentosBloquear]
Carpeta=Lista
Clave=MovilUsuarioCfg.IntentosBloquear
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=10
[Lista.MovilUsuarioCfg.DiasHistorico]
Carpeta=Lista
Clave=MovilUsuarioCfg.DiasHistorico
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=10
[Lista.MovilUsuarioCfg.Movimiento]
Carpeta=Lista
Clave=MovilUsuarioCfg.Movimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.MovilUsuarioCfg.UltimaSincro]
Carpeta=Lista
Clave=MovilUsuarioCfg.UltimaSincro
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco




Tamano=20

[Lista.Columnas]
0=91
1=267
Almacen=90
Nombre=229
Grupo=100
Sucursal=46


























Moneda=144
TipoCambio=69
[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Crerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S












[Lista.MovilUsuarioCfg.MonedaBase]
Carpeta=Lista
Clave=MovilUsuarioCfg.MonedaBase
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.MovilUsuarioCfg.CobrosAConsultar]
Carpeta=Lista
Clave=MovilUsuarioCfg.CobrosAConsultar
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco




Tamano=10
[Lista.MovilUsuarioCfg.MovimientoCobro]
Carpeta=Lista
Clave=MovilUsuarioCfg.MovimientoCobro
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco



[Lista.MovilUsuarioCfg.MovimientoAnticipo]
Carpeta=Lista
Clave=MovilUsuarioCfg.MovimientoAnticipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco













[Lista.ListaEnCaptura]
(Inicio)=MovilUsuarioCfg.Agente
MovilUsuarioCfg.Agente=Agente.Nombre
Agente.Nombre=MovilUsuarioCfg.PedidosAConsultar
MovilUsuarioCfg.PedidosAConsultar=MovilUsuarioCfg.CobrosAConsultar
MovilUsuarioCfg.CobrosAConsultar=MovilUsuarioCfg.DiasHistorico
MovilUsuarioCfg.DiasHistorico=MovilUsuarioCfg.IntentosBloquear
MovilUsuarioCfg.IntentosBloquear=MovilUsuarioCfg.MonedaBase
MovilUsuarioCfg.MonedaBase=MovilUsuarioCfg.Sucursal
MovilUsuarioCfg.Sucursal=MovilUsuarioCfg.Movimiento
MovilUsuarioCfg.Movimiento=MovilUsuarioCfg.MovimientoCobro
MovilUsuarioCfg.MovimientoCobro=MovilUsuarioCfg.MovimientoAnticipo
MovilUsuarioCfg.MovimientoAnticipo=MovilUsuarioCfg.UltimaSincro
MovilUsuarioCfg.UltimaSincro=MovilUsuarioCfg.ContrasenaCorta
MovilUsuarioCfg.ContrasenaCorta=(Fin)

[Lista.MovilUsuarioCfg.Sucursal]
Carpeta=Lista
Clave=MovilUsuarioCfg.Sucursal
Editar=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
