[Forma]
Clave=Neteo
Nombre=Netear -  Cuenta por Cobrar vs. Cuenta por Pagar
Icono=0
Modulos=(Todos)
ListaCarpetas=Ficha
CarpetaPrincipal=Ficha
PosicionInicialAlturaCliente=207
PosicionInicialAncho=567
IniciarAgregando=S
PosicionInicialIzquierda=359
PosicionInicialArriba=394
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
ListaAcciones=(Lista)

[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Neteo
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=$00004080
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CarpetaVisible=S

[Ficha.Neteo.Moneda]
Carpeta=Ficha
Clave=Neteo.Moneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Neteo.Cliente]
Carpeta=Ficha
Clave=Neteo.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Cte.Nombre]
Carpeta=Ficha
Clave=Cte.Nombre
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=41
ColorFondo=Plata
ColorFuente=Negro

[Ficha.Neteo.CxcMov]
Carpeta=Ficha
Clave=Neteo.CxcMov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Neteo.CxcMovID]
Carpeta=Ficha
Clave=Neteo.CxcMovID
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.CxcPendiente.Saldo]
Carpeta=Ficha
Clave=CxcPendiente.Saldo
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Plata
ColorFuente=$00808040
Tamano=20
Efectos=[Negritas]

[Ficha.Neteo.Proveedor]
Carpeta=Ficha
Clave=Neteo.Proveedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Prov.Nombre]
Carpeta=Ficha
Clave=Prov.Nombre
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=41
ColorFondo=Plata
ColorFuente=Negro

[Ficha.Neteo.CxpMov]
Carpeta=Ficha
Clave=Neteo.CxpMov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Neteo.CxpMovID]
Carpeta=Ficha
Clave=Neteo.CxpMovID
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.CxpPendiente.Saldo]
Carpeta=Ficha
Clave=CxpPendiente.Saldo
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Plata
ColorFuente=$00004080
Tamano=20
Efectos=[Negritas]

[Ficha.Importe]
Carpeta=Ficha
Clave=Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Acciones.Generar]
Nombre=Generar
Boton=7
NombreEnBoton=S
NombreDesplegar=<T>&Generar<T>
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
ConCondicion=S
Antes=S
DespuesGuardar=S
Visible=S
EjecucionCondicion=Neteo:Importe>0
AntesExpresiones=Si<BR>  Precaucion(<T>¿ Esta Seguro ?<T>,BotonSi,BotonNo)=BotonSi<BR>Entonces<BR>  ProcesarSQL(<T>spNeteo :nID<T>, Neteo:Neteo.ID)<BR>Sino<BR>  AbortarOperacion<BR>Fin

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

[Forma.ListaAcciones]
(Inicio)=Generar
Generar=Cancelar
Cancelar=(Fin)

[Ficha.ListaEnCaptura]
(Inicio)=Neteo.Moneda
Neteo.Moneda=Neteo.Cliente
Neteo.Cliente=Cte.Nombre
Cte.Nombre=Neteo.CxcMov
Neteo.CxcMov=Neteo.CxcMovID
Neteo.CxcMovID=CxcPendiente.Saldo
CxcPendiente.Saldo=Neteo.Proveedor
Neteo.Proveedor=Prov.Nombre
Prov.Nombre=Neteo.CxpMov
Neteo.CxpMov=Neteo.CxpMovID
Neteo.CxpMovID=CxpPendiente.Saldo
CxpPendiente.Saldo=Importe
Importe=(Fin)
