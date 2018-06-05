
[Forma]
Clave=eCollaborationProvCte
Icono=0
Modulos=(Todos)
Nombre=Mapeo Proveedor/Cliente Intercompañia

ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=452
PosicionInicialArriba=224
PosicionInicialAlturaCliente=162
PosicionInicialAncho=363
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
Comentarios=Asigna( eCollaborationProvCte:eCollaborationProvCte.ModuloOrigen,Info.Modulo )<BR>Asigna( eCollaborationProvCte:eCollaborationProvCte.MovimientoOrigen,Info.Mov )<BR>Info.Modulo+<T> - <T>+Info.Mov
VentanaTipoMarco=Normal
VentanaPosicionInicial=Por diseño
VentanaEstadoInicial=Normal
VentanaColor=Plata
ExpresionesAlMostrar=Asigna(Info.Valor,SQL(<T>SELECT GastoConceptosInventariables FROM EmpresaCfg2 WHERE Empresa = :tEmpresa<T>,Info.Empresa))
[Lista]
Estilo=Ficha
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
Vista=eCollaborationProvCte
ListaEnCaptura=(Lista)

PermiteEditar=S

Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaAlineacionDerecha=S
FichaColorFondo=Plata
FiltroGeneral=eCollaborationProvCte.MovimientoOrigen=<T>{Info.Mov}<T> AND<BR>eCollaborationProvCte.ModuloOrigen=<T>{Info.Modulo}<T>
[Lista.eCollaborationProvCte.EmpresaProv]
Carpeta=Lista
Clave=eCollaborationProvCte.EmpresaProv
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

EspacioPrevio=N
[Lista.eCollaborationProvCte.Proveedor]
Carpeta=Lista
Clave=eCollaborationProvCte.Proveedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

EspacioPrevio=N
EditarConBloqueo=S
[Lista.eCollaborationProvCte.EmpresaCte]
Carpeta=Lista
Clave=eCollaborationProvCte.EmpresaCte
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

EspacioPrevio=N
[Lista.eCollaborationProvCte.Cliente]
Carpeta=Lista
Clave=eCollaborationProvCte.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco



EspacioPrevio=N
[Lista.Columnas]
EmpresaProv=111
Proveedor=108
EmpresaCte=121
Cliente=117
ModuloOrigen=70
MovimientoOrigen=124

Empresa=71
Nombre=371
0=116
1=266
RFC=107



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




















[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=(Variables)
(Variables)=(Fin)







































[Lista.ListaEnCaptura]
(Inicio)=eCollaborationProvCte.Proveedor
eCollaborationProvCte.Proveedor=eCollaborationProvCte.Cliente
eCollaborationProvCte.Cliente=eCollaborationProvCte.EmpresaCte
eCollaborationProvCte.EmpresaCte=eCollaborationProvCte.EmpresaProv
eCollaborationProvCte.EmpresaProv=(Fin)
