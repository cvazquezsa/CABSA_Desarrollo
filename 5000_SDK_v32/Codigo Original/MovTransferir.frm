[Forma]
Clave=MovTransferir
Nombre=Transferir Movimiento
Icono=0
Modulos=(Todos)
ListaCarpetas=(Variables)
CarpetaPrincipal=(Variables)
PosicionInicialIzquierda=299
PosicionInicialArriba=441
PosicionInicialAlturaCliente=115
PosicionInicialAncho=682
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
Comentarios=e(<T>Propietario Actual:<T>)+<T> <T>+Info.Usuario

[(Variables)]
Estilo=Ficha
Clave=(Variables)
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

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
Antes=S
DespuesGuardar=S
AntesExpresiones=Si<BR>  Info.Usuario=Info.UsuarioNuevo<BR>Entonces<BR>  Error(<T>No puede ser el mismo<T>)<BR>  AbortarOperacion<BR>Sino<BR>  Si<BR>    SQL(<T>SELECT COUNT(*) FROM Usuario WHERE Usuario=:tUsuario AND Estatus=:tEstatus<T>, Info.UsuarioNuevo, EstatusAlta)=0<BR>  Entonces<BR>    Error(<T>El Usuario no esta dado de Alta<T>)<BR>    AbortarOperacion<BR>  Fin<BR>Fin

[(Variables).Info.Observaciones]
Carpeta=(Variables)
Clave=Info.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=80
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreEnBoton=S
NombreDesplegar=<T>&Cancelar<T>
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

[(Variables).Info.UsuarioNuevo]
Carpeta=(Variables)
Clave=Info.UsuarioNuevo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.Prioridad]
Carpeta=(Variables)
Clave=Info.Prioridad
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=(Fin)

[(Variables).ListaEnCaptura]
(Inicio)=Info.UsuarioNuevo
Info.UsuarioNuevo=Info.Observaciones
Info.Observaciones=Info.Prioridad
Info.Prioridad=(Fin)
